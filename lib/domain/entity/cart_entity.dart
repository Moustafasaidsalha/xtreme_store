import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';

class CartEntity extends Equatable {
  final List<SubCarts> products;
  final double subTotal;
  final double shippingFees;
  final double coupon;
  final double total;
  final String currency;
  final int cartID;
  final String couponName;

  const CartEntity({
    this.products = const [],
    this.subTotal = 0,
    this.shippingFees = 0,
    this.coupon = 0,
    this.total = 0,
    this.currency = '',
    this.cartID = 0,
    this.couponName = '',
  });

  CartEntity copyWith({
    List<SubCarts>? products,
    double? subTotal,
    double? shippingFees,
    double? coupon,
    double? total,
    String? currency,
    int? cartID,
    String? couponName,
  }) {
    return CartEntity(
      products: products ?? this.products,
      subTotal: subTotal ?? this.subTotal,
      shippingFees: shippingFees ?? this.shippingFees,
      coupon: coupon ?? this.coupon,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      cartID: cartID ?? this.cartID,
      couponName: couponName ?? this.couponName,
    );
  }

  @override
  List<Object?> get props => [
        products,
        subTotal,
        shippingFees,
        coupon,
        total,
        currency,
        cartID,
        couponName,
      ];
}
