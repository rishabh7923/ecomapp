part of 'catalogue_bloc.dart';

@immutable
sealed class CatalogueState {

}

abstract class CatalogueActionState extends CatalogueState {}

class CatalogueInitial extends CatalogueState {}
class CatalogueLoadingState extends CatalogueState {}

class CatalogueLoadedSuccessState extends CatalogueState {
  final List<ProductDataModel> products;
  final bool hasReachedMax;

  CatalogueLoadedSuccessState({
    required this.products,
    this.hasReachedMax = false,
  });
}

class CatalogueErrorState extends CatalogueState {
  final String errorMessage;

  CatalogueErrorState({required this.errorMessage});
}


class CatalogueNavigateToCartPageActionState extends CatalogueActionState {}
class CatalogueCartRefreshedActionState extends CatalogueActionState {}
