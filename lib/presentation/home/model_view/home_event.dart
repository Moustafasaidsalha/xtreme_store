import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBannersEvent extends HomeEvents {
  // final GetBannersParams getBannersParams;
  //
  // GetBannersEvent(this.getBannersParams);
  //
  // @override
  // List<Object> get props => [getBannersParams];

}

class GetCategoriesEvent extends HomeEvents {
  // final GetCategoriesParams getCategoriesParams;
  //
  // GetCategoriesEvent(this.getCategoriesParams);
  //
  // @override
  // List<Object> get props => [getCategoriesParams];
}

class GetNewInEvent extends HomeEvents {
  // final GetProductsParams getProductsParams;
  //
  // GetNewInEvent(this.getProductsParams);
  //
  // @override
  // List<Object> get props => [getProductsParams];
}

class GetBestSellerEvent extends HomeEvents {
  // final GetProductsParams getProductsParams;
  //
  // GetBestSellerEvent(this.getProductsParams);
  //
  // @override
  // List<Object> get props => [getProductsParams];

}

class GetOffersEvent extends HomeEvents {
  // final GetProductsParams getProductsParams;
  //
  // GetOffersEvent(this.getProductsParams);
  //
  // @override
  // List<Object> get props => [getProductsParams];
}