part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveProductFromCartEvent extends CartEvent{
  final ProductDataModel product;

  CartRemoveProductFromCartEvent({required this.product});
}

class CartProductQuantityDecreasedEvent extends CartEvent{
  final ProductDataModel product;

  CartProductQuantityDecreasedEvent({required this.product});
}

class CartProductQuantityIncreasedEvent extends CartEvent{
  final ProductDataModel product;

  CartProductQuantityIncreasedEvent({required this.product});
}
