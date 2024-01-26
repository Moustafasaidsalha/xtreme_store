import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/banner.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class HomeStates extends Equatable {
  final RequestStates offersState;
  final RequestStates bannersState;
  final RequestStates themeState;
  final RequestStates newInState;
  final RequestStates categoriesState;
  final RequestStates bestSellerState;
  final BannersModel? bannersModel;
  final CategoriesModel? categoriesModel;
  final ProductsModel? newInModel;
  final ProductsModel? bestSellerModel;
  final ProductsModel? offersModel;

  HomeStates copyWith({
    RequestStates? offersState,
    RequestStates? themeState,
    RequestStates? bannersState,
    RequestStates? newInState,
    RequestStates? categoriesState,
    RequestStates? bestSellerState,
    BannersModel? bannersModel,
    CategoriesModel? categoriesModel,
    ProductsModel? newInModel,
    ProductsModel? bestSellerModel,
    ProductsModel? offersModel,
  }) {
    return HomeStates(
        offersState: offersState ?? this.offersState,
        bannersState: bannersState ?? this.bannersState,
        newInState: newInState ?? this.newInState,
        categoriesState: categoriesState ?? this.categoriesState,
        bestSellerState: bestSellerState ?? this.bestSellerState,
        categoriesModel: categoriesModel ?? this.categoriesModel,
        bannersModel: bannersModel ?? this.bannersModel,
        bestSellerModel: bestSellerModel ?? this.bestSellerModel,
        newInModel: newInModel ?? this.newInModel,
        themeState: themeState ?? this.themeState,
        offersModel: offersModel ?? this.offersModel);
  }

  @override
  List<Object?> get props => [
        offersState,
        bannersState,
        newInState,
        categoriesState,
        bestSellerState,
        bannersModel,
        categoriesModel,
        newInModel,
        bestSellerModel,
        offersModel,
        themeState,
      ];

  const HomeStates({
    this.offersState = RequestStates.loading,
    this.bannersState = RequestStates.loading,
    this.newInState = RequestStates.loading,
    this.categoriesState = RequestStates.loading,
    this.bestSellerState = RequestStates.loading,
    this.themeState = RequestStates.loading,
    this.bannersModel,
    this.categoriesModel,
    this.newInModel,
    this.bestSellerModel,
    this.offersModel,
  });
}
