import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/product.dart';

abstract class BestSellerStates extends Equatable {
}

class InitialState extends BestSellerStates {
  @override
  List<Object> get props => [];
}

class GetBestSellerLoadingState extends BestSellerStates {
  @override
  List<Object> get props => [];
}

class GetBestSellerSuccessState extends BestSellerStates {
  final ProductsModel? bestSellerProductsModel;

  GetBestSellerSuccessState({
    required this.bestSellerProductsModel,
  });

  @override
  List<Object?> get props => [bestSellerProductsModel];
}


class GetBestSellerErrorState extends BestSellerStates {
  @override
  List<Object> get props => [];
}
