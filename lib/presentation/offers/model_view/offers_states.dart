// import 'package:equatable/equatable.dart';
// import 'package:extreme_store/data/models/product.dart';
//
// abstract class OffersStates extends Equatable {}
//
// class InitialState extends OffersStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetOffersLoadingState extends OffersStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetOffersSuccessState extends OffersStates {
//   final List<ProductModel> offersProductsModel;
//
//   GetOffersSuccessState({
//     required this.offersProductsModel,
//   });
//
//   @override
//   List<Object?> get props => [offersProductsModel];
// }
//
// class GetOffersErrorState extends OffersStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetOffersMoreErrorState extends OffersStates {
//   @override
//   List<Object> get props => [];
// }

import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/product.dart';

class OffersState extends Equatable {
  const OffersState({
    this.status = StateStatus.initial,
    this.products = const <ProductModel>[],
    this.hasReachedMax = false,
  });

  final StateStatus status;
  final List<ProductModel> products;
  final bool hasReachedMax;

  OffersState copyWith({
    StateStatus? status,
    List<ProductModel>? products,
    bool? hasReachedMax,
  }) {
    return OffersState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
