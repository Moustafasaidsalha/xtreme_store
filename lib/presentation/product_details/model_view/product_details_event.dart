import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductDetailsEvents extends Equatable {
}

class GetProductDetailsEvent extends ProductDetailsEvents {
  final int productId;

  GetProductDetailsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class GetProductsDynamicVariantsEvent extends ProductDetailsEvents {
  final int productId;

  GetProductsDynamicVariantsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class GetChangeProductsVariants extends ProductDetailsEvents {
  final int code;
  final List<String> variantValueIds;
  final BuildContext context;

  GetChangeProductsVariants(this.code, this.variantValueIds,
      {required this.context});

  @override
  List<Object> get props => [code, context];
}

class GetSimilarProductsEvent extends ProductDetailsEvents {
  final int categoryId;

  @override
  List<Object> get props => [categoryId];

  GetSimilarProductsEvent({
    required this.categoryId,
  });
}

class SetWishListEvent extends ProductDetailsEvents {
  final int productId;
  final BuildContext context;

  @override
  List<Object> get props => [productId,context];

  SetWishListEvent({
    required this.productId,
    required this.context,
  });
}

class AddToCounterListEvent extends ProductDetailsEvents {
  final int index;
  final double totalPrice;

  @override
  List<Object> get props => [index, totalPrice];

  AddToCounterListEvent({
    required this.index,
    required this.totalPrice,
  });
}

class RemoveFromCounterListEvent extends ProductDetailsEvents {
  final int index;
  final double totalPrice;

  @override
  List<Object> get props => [index, totalPrice];

  RemoveFromCounterListEvent({
    required this.index,
    required this.totalPrice,
  });
}

class NotifyMeEvent extends ProductDetailsEvents {
  final int productId;
  final BuildContext context;

  @override
  List<Object> get props => [productId,context];

   NotifyMeEvent({
    required this.productId,
    required this.context,
  });
}

class ChangeQuantityEvent extends ProductDetailsEvents {
  final int amount;
  final double totalPrice;

  @override
  List<Object> get props => [amount, totalPrice];

  ChangeQuantityEvent({
    required this.amount,
    required this.totalPrice,
  });
}

class IsSelectedEvent extends ProductDetailsEvents {
  final double totalPrice;

  @override
  List<Object> get props => [totalPrice];


  IsSelectedEvent({
    required this.totalPrice,
  });
}
