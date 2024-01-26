import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/dynamic_variants.dart';
import 'package:extreme_store/data/models/product.dart';

enum RequestStates {
  loading,
  success,
  error
}

class ProductDetailsStates extends Equatable {
  final RequestStates addToListState;
  final RequestStates removeFromListState;
  final RequestStates isSelectedState;
  final RequestStates changeQuantityState;
  final RequestStates productDetailsState;
  final RequestStates changeProductDynamicState;
  final RequestStates changeProductVariantsState;
  final ProductDataModel? productDataModel;
  final RequestStates productDynamicVariantsState;
  final List<DynamicVariantModel>? dynamicVariantModel;
  final List<DynamicVariantModel>? dynamicVariantHasAmountModel;
  final List<DynamicVariantModel>? dynamicVariantHasNoAmountModel;
  final RequestStates similarProductsState;
  final List<ProductModel>? similarProducts;
  final RequestStates setWishListState;
  final String? message;
  final double? totalPrice;
  final Map<int, int>? dynamicVariants;
  final  Map<int,Map<int,double>> dynamicVariantsDetails;
final int counter;

  const  ProductDetailsStates({
    this.dynamicVariants,
    this.dynamicVariantHasAmountModel,
    this.dynamicVariantHasNoAmountModel,
    this.isSelectedState=RequestStates.loading,
    this.changeQuantityState=RequestStates.loading,
    this.addToListState=RequestStates.loading,
    this.removeFromListState=RequestStates.loading,
    this.counter=0,
     this.dynamicVariantsDetails=const{},
     this.productDetailsState=RequestStates.loading,
     this.changeProductDynamicState=RequestStates.loading,
     this.setWishListState=RequestStates.loading,
    this.productDataModel,
    this.similarProductsState=RequestStates.loading,
    this.similarProducts,
    this.message='',
    this.totalPrice=0,
    this.changeProductVariantsState=RequestStates.loading,
     this.productDynamicVariantsState=RequestStates.loading,
    this.dynamicVariantModel,
  });
  ProductDetailsStates copyWith({
     Map<int, int>? dynamicVariants,
     int? counter,
     Map<int,Map<int,double>>? dynamicVariantsDetails,
    RequestStates? setWishListState,
    RequestStates? addToListState,
    RequestStates? changeQuantityState,
    RequestStates? removeFromListState,
    RequestStates? isSelectedState,
    RequestStates? changeProductDynamicState,
     RequestStates? productDetailsState,
     RequestStates? changeProductVariantsState,
     ProductDataModel? productDataModel,
     RequestStates? productDynamicVariantsState,
     List<DynamicVariantModel>? dynamicVariantModel,
     List<DynamicVariantModel>? dynamicVariantHasAmountModel,
     List<DynamicVariantModel>? dynamicVariantHasNoAmountModel,
     RequestStates? similarProductsState,
     List<ProductModel>? similarProducts,
    String? message,
    double? totalPrice,
}){
    return ProductDetailsStates(
      setWishListState: setWishListState??this.setWishListState,
      counter: counter??this.counter,
      changeQuantityState: changeQuantityState??this.changeQuantityState,
      dynamicVariantHasAmountModel: dynamicVariantHasAmountModel??this.dynamicVariantHasAmountModel,
      dynamicVariantHasNoAmountModel: dynamicVariantHasNoAmountModel??this.dynamicVariantHasNoAmountModel,
      isSelectedState: isSelectedState??this.isSelectedState,
      addToListState: addToListState??this.addToListState,
      removeFromListState: removeFromListState??this.removeFromListState,
        changeProductDynamicState: changeProductDynamicState??this.changeProductDynamicState,
        productDataModel:productDataModel?? this.productDataModel,
        changeProductVariantsState:changeProductVariantsState?? this.changeProductVariantsState,
      dynamicVariantModel:dynamicVariantModel?? this.dynamicVariantModel,
      productDetailsState:productDetailsState??this.productDetailsState ,
      productDynamicVariantsState: productDynamicVariantsState??this.productDynamicVariantsState,
        similarProducts:similarProducts??this.similarProducts ,
      similarProductsState: similarProductsState??this.similarProductsState,
      message: message??this.message,
      totalPrice: totalPrice??this.totalPrice,
      dynamicVariants: dynamicVariants??this.dynamicVariants,
      dynamicVariantsDetails: dynamicVariantsDetails??this.dynamicVariantsDetails,
    );
  }

  @override
  List<Object?> get props =>
      [
        productDetailsState,
        productDataModel,
        productDynamicVariantsState,
        dynamicVariantModel,
        changeProductVariantsState,
        similarProducts,
        similarProductsState,
        setWishListState,
         message,
        changeProductDynamicState,
        totalPrice,
        dynamicVariants,
        dynamicVariantsDetails,
        counter,
        addToListState,
        removeFromListState,
        isSelectedState,
        dynamicVariantHasAmountModel,
        dynamicVariantHasNoAmountModel,changeQuantityState
      ];
}