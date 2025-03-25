import 'dart:async';
import 'dart:convert'; 
import 'package:bloc/bloc.dart';
import 'package:ecomapp/data/cart_items.dart';
import 'package:ecomapp/features/catalogue/models/product_data.dart';
import 'package:http/http.dart' as http; 
import 'package:meta/meta.dart';

part 'catalogue_event.dart';
part 'catalogue_state.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueState> {

  int _page = 1;
  static const int _perPage = 10;
  List<ProductDataModel> _allProducts = [];
  
  CatalogueBloc() : super(CatalogueInitial()) {
    on<CatalogueInitialEvent>(catalogueInitialEvent);
    on<CatalogueProductCartButtonClickedEvent>(catalogueProductCartButtonClickedEvent);
    on<CatalogueCartButtonNavigationEvent>(catalogueCartButtonNavigationEvent);
    on<CatalogueRefreshCartEvent>((event, emit) {
      emit(CatalogueCartRefreshedActionState());
    });

    on<CatalogueLoadMoreEvent>(catalogueLoadMoreEvent);
  }
  

  FutureOr<void> catalogueInitialEvent(
    CatalogueInitialEvent event,
    Emitter<CatalogueState> emit,
  ) async {
    emit(CatalogueLoadingState());
    
    _page = 1;
    _allProducts = [];
    
    try {
      final products = await _fetchProducts(_page, _perPage);
      _allProducts = products;
      
      final bool hasReachedMax = products.length < _perPage;
      
      emit(CatalogueLoadedSuccessState(
        products: _allProducts,
        hasReachedMax: hasReachedMax,
      ));
    } catch (e) {
      emit(CatalogueErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> catalogueLoadMoreEvent(
    CatalogueLoadMoreEvent event,
    Emitter<CatalogueState> emit,
  ) async {

    if (state is CatalogueLoadedSuccessState &&
        (state as CatalogueLoadedSuccessState).hasReachedMax) {
      return;
    }
    
    try {
      _page++;
      
      final newProducts = await _fetchProducts(_page, _perPage);
      
      if (newProducts.isEmpty) {
        emit(CatalogueLoadedSuccessState(
          products: _allProducts,
          hasReachedMax: true,
        ));
      } else {
        _allProducts.addAll(newProducts);
        final hasReachedMax = newProducts.length < _perPage;
        
        emit(CatalogueLoadedSuccessState(
          products: _allProducts,
          hasReachedMax: hasReachedMax,
        ));
      }
    } catch (e) {
      print('Error loading more products: ${e.toString()}');
    }
  }
  
  Future<List<ProductDataModel>> _fetchProducts(int page, int perPage) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=$perPage&skip=${(page - 1) * perPage}')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((product) => ProductDataModel.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load products. Status code: ${response.statusCode}');
    }
  }

  FutureOr<void> catalogueProductCartButtonClickedEvent(
    CatalogueProductCartButtonClickedEvent event,
    Emitter<CatalogueState> emit,
  ) {
    print('Product Added to Cart ${cartItems.length}');

    final existingProduct = cartItems.cast<ProductDataModel?>().firstWhere(
      (product) => product?.id == event.clickedProduct.id,
      orElse: () => null,
    );

    if (existingProduct != null) {
      existingProduct.quantity += 1;
    } else {
      event.clickedProduct.quantity = 1;
      cartItems.add(event.clickedProduct);
    }

    emit(CatalogueCartRefreshedActionState());
  }

  FutureOr<void> catalogueCartButtonNavigationEvent(
    CatalogueCartButtonNavigationEvent event,
    Emitter<CatalogueState> emit,
  ) {
    print('Cart Clicked');
    emit(CatalogueNavigateToCartPageActionState());
  }
}
