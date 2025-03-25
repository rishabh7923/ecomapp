import 'package:ecomapp/data/cart_items.dart';
import 'package:ecomapp/features/cart/ui/cart.dart';
import 'package:ecomapp/features/catalogue/bloc/catalogue_bloc.dart';
import 'package:ecomapp/features/catalogue/widgets/cart_icon_widget.dart';
import 'package:ecomapp/features/catalogue/widgets/product_card.dart';
import 'package:ecomapp/features/catalogue/widgets/skeleton_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  final CatalogueBloc catalogueBloc = CatalogueBloc();
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    catalogueBloc.add(CatalogueInitialEvent());
    
    _scrollController.addListener(_onScroll);
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    if (_isBottom) {
      catalogueBloc.add(CatalogueLoadMoreEvent());
    }
  }
  
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    
    return currentScroll >= (maxScroll - 30); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogueBloc, CatalogueState>(
      bloc: catalogueBloc,
      listenWhen: (previous, current) => current is CatalogueActionState,
      buildWhen: (previous, current) => current is! CatalogueActionState,
      listener: (context, state) {
        if (state is CatalogueNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          ).then((_) {
            catalogueBloc.add(CatalogueRefreshCartEvent());
          });
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CatalogueLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case CatalogueLoadedSuccessState:
            final successState = state as CatalogueLoadedSuccessState;
            final products = successState.products;
            final hasReachedMax = successState.hasReachedMax;

            return Scaffold(
              appBar: AppBar(
                title: Text('Catalogue'),
                centerTitle: true,
                backgroundColor: Colors.pink[50],
                actions: [CartIconWidget(catalogueBloc: catalogueBloc)],
              ),
              body: Container(
                color: Colors.pink[50],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.70,
                    ),
                    itemCount: hasReachedMax 
                        ? products.length 
                        : products.length + 2,
                    itemBuilder: (context, index) {
                        if (index >= products.length) { 
                          return SkeletonCardWidget();
                        }
                      
                      final product = products[index];
                      return ProductCardWidget(
                        productDataModel: product,
                        catalogueBloc: catalogueBloc,
                      );
                    },
                  ),
                ),
              ),
            );
          case CatalogueErrorState:
            return Scaffold(
              appBar: AppBar(title: Text('Catalogue')),
              body: Center(
                child: Text((state as CatalogueErrorState).errorMessage),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
