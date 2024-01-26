import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class CategoryStates extends Equatable {
  final RequestStates getNewInState;
  final RequestStates getOffersState;
  final RequestStates getBestSellerState;
  final ProductsModel? newInProductsModel;
  final ProductsModel? offersProductsModel;
  final ProductsModel? bestSellerProductsModel;

  const CategoryStates({
    this.getNewInState = RequestStates.loading,
    this.getOffersState = RequestStates.loading,
    this.getBestSellerState = RequestStates.loading,
    this.newInProductsModel,
    this.offersProductsModel,
    this.bestSellerProductsModel,
  });

  CategoryStates copyWith({
    RequestStates? getNewInState,
    RequestStates? getOffersState,
    RequestStates? getBestSellerState,
    ProductsModel? newInProductsModel,
    ProductsModel? offersProductsModel,
    ProductsModel? bestSellerProductsModel,
  }) {
    return CategoryStates(
        offersProductsModel:offersProductsModel??this.offersProductsModel, newInProductsModel:newInProductsModel??this.newInProductsModel, bestSellerProductsModel:bestSellerProductsModel??this.bestSellerProductsModel,
        getBestSellerState:getBestSellerState??this.getBestSellerState, getNewInState:getNewInState??this.getNewInState, getOffersState:getOffersState??this.getOffersState);
  }

  @override
  List<Object?> get props =>
      [
        getNewInState,
        getOffersState,
        getBestSellerState,
        newInProductsModel,
        offersProductsModel,
        bestSellerProductsModel,
      ];
}
