// import 'package:equatable/equatable.dart';
// import 'package:extreme_store/data/models/product.dart';
//
// abstract class NewInStates extends Equatable {
// }
//
// class InitialState extends NewInStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetNewInLoadingState extends NewInStates {
//   @override
//   List<Object> get props => [];
// }
//
// class GetNewInSuccessState extends NewInStates {
//
//   @override
//   List<Object?> get props => [newInProductsModel];
//   final ProductsModel? newInProductsModel;
//
//   GetNewInSuccessState({
//     required this.newInProductsModel,
//   });
// }
//
// class GetNewInErrorState extends NewInStates {
//   @override
//   List<Object> get props => [];
// }

import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/product.dart';

import '../../../app/enums/state_status.dart';

class NewInState extends Equatable {
  final StateStatus stateStatus;
  final List<ProductModel> newInProducts;
  final bool hasReachedMax;
  final bool loadingMore;
  final String errorMessage;

  const NewInState({
    this.stateStatus = StateStatus.initial,
    this.newInProducts = const [],
    this.hasReachedMax = false,
    this.loadingMore = false,
    this.errorMessage = '',
  });

  NewInState copyWith({
    StateStatus? stateStatus,
    List<ProductModel>? newInProducts,
    bool? hasReachedMax,
    bool? loadingMore,
    String? errorMessage,
  }) {
    return NewInState(
      stateStatus: stateStatus ?? this.stateStatus,
      newInProducts: newInProducts ?? this.newInProducts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }

  @override
  List<Object?> get props => [stateStatus, newInProducts, hasReachedMax,loadingMore];
}
