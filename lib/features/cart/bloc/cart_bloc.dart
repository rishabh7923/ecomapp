import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomapp/data/cart_items.dart';
import 'package:ecomapp/features/catalogue/models/product_data.dart'
    show ProductDataModel;
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartProductQuantityIncreasedEvent>(cartProductQuantityIncreasedEvent);
    on<CartProductQuantityDecreasedEvent>(cartProductQuantityDecreasedEvent);
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveProductFromCartEvent(
    CartRemoveProductFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    final productIndex = cartItems.indexWhere(
      (product) => product.id == event.product.id,
    );

    final product = cartItems[productIndex];

    if (product.quantity > 1) {
      product.quantity--;
    } else {
      cartItems.removeAt(productIndex);
    }

    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartProductQuantityDecreasedEvent(
    CartProductQuantityDecreasedEvent event,
    Emitter<CartState> emit,
  ) {
    final productIndex = cartItems.indexWhere(
      (product) => product.id == event.product.id,
    );

    final product = cartItems[productIndex];

    if (product.quantity > 1) {
      product.quantity--;
    } else {
      cartItems.removeAt(productIndex);
    }

    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartProductQuantityIncreasedEvent(
    CartProductQuantityIncreasedEvent event,
    Emitter<CartState> emit,
  ) {
    final productIndex = cartItems.indexWhere(
      (product) => product.id == event.product.id,
    );

    final product = cartItems[productIndex];
    product.quantity++;

    emit(CartSuccessState(cartItems: cartItems));
  }
}
