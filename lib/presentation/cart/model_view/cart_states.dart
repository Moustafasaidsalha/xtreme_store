// import 'package:equatable/equatable.dart';
// import 'package:extreme_store/data/models/product.dart';
//
// abstract class CartStates extends Equatable {
// }
//
// class InitialState extends CartStates {
//   @override
//   List<Object> get props => [];
// }
// class GetProductLoadingState extends CartStates {
//   @override
//   List<Object> get props => [];
// }
// class GetProductSuccessState extends CartStates {
//   final ProductDetailsModel? productDetailsModel;
//
//   GetProductSuccessState({required this.productDetailsModel});
//
//   @override
//   List<Object?> get props => [productDetailsModel];
// }
// class GetProductErrorState extends CartStates {
//   @override
//   List<Object> get props => [];
// }

import 'package:equatable/equatable.dart';
import 'package:extreme_store/domain/entity/cart_entity.dart';

import '../../../app/enums/state_status.dart';

enum CouponState {
  initial,
  valid,
  unValid,
  failure,
  userNotDefined,
}

class CartSate extends Equatable {
  const CartSate({
    this.status = StateStatus.initial,
    this.changeState = StateStatus.initial,
    this.couponName = '',
    this.couponState = CouponState.initial,
    this.message = '',
    this.couponMessage = '',
    this.cartEntity = const CartEntity(
      products: [],
      coupon: 0,
      subTotal: 0,
      total: 0,
      shippingFees: 0,
      currency: '',
    ),
  });

  final StateStatus status;
  final CartEntity cartEntity;
  final String message;
  final StateStatus changeState;
  final CouponState couponState;
  final String couponMessage;
  final String couponName;

  CartSate copyWith({
    StateStatus? status,
    StateStatus? changeState,
    CouponState? couponState,
    CartEntity? cartEntity,
    String? message,
    String? couponName,
    String? couponMessage,
  }) {
    return CartSate(
      status: status ?? this.status,
      changeState: changeState ?? this.changeState,
      cartEntity: cartEntity ?? this.cartEntity,
      message: message ?? this.message,
      couponState: couponState ?? this.couponState,
      couponName: couponName ?? this.couponName,
      couponMessage: couponMessage ?? this.couponMessage,
    );
  }

  @override
  String toString() {
    return '''cartState { status: $status, cart: $cartEntity }''';
  }

  @override
  List<Object> get props => [
        status,
        cartEntity,
        message,
        changeState,
        couponState,
        couponName,
        couponMessage
      ];
}
