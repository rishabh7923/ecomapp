part of 'catalogue_bloc.dart';

@immutable
sealed class CatalogueEvent {}

class CatalogueInitialEvent extends CatalogueEvent {}

class CatalogueCartButtonNavigationEvent extends CatalogueEvent {}

class CatalogueProductCartButtonClickedEvent extends CatalogueEvent {
  final ProductDataModel clickedProduct;

  CatalogueProductCartButtonClickedEvent({required this.clickedProduct});
}

class CatalogueRefreshCartEvent extends CatalogueEvent {}

class CatalogueLoadMoreEvent extends CatalogueEvent {}
