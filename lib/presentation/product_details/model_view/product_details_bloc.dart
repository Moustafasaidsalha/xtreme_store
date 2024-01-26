
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/add_to_cart_body.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_to_cart.dart';
import 'package:extreme_store/domain/uses_cases/get_change_of_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_dynamic_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/domain/uses_cases/notify_me.dart';
import 'package:extreme_store/domain/uses_cases/set_wishlist_item.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_event.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/product_details/widgets/add_product_pop_up_widget.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_cubit.dart';

import '../../../data/models/dynamic_variants.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvents,ProductDetailsStates>{
  ProductDetailsBloc(this.notifyMeUseCase,this.setWishlistItemUseCase ,this.getProductsUseCase,this.getProductDynamicVariantsDetailsUseCase,this.getChangeOfProductDetailsUseCase,this.getProductDetailsUseCase,this.addToCart)
      :super(const ProductDetailsStates()){
    on<GetProductDetailsEvent>(getProductDetails);
    on<GetProductsDynamicVariantsEvent>(getDynamicVariants);
    on<GetChangeProductsVariants>(getChangeProductVariants);
    on<GetSimilarProductsEvent>(getSimilarProducts);
    on<SetWishListEvent>(setWishlist);
    on<AddToCounterListEvent>(addToCounterList);
    on<RemoveFromCounterListEvent>(minusFromCounterList);
    on<IsSelectedEvent>(isSelected);
    on<ChangeQuantityEvent>(changeQuantityAmount);
    on<NotifyMeEvent>(notifyMe);
  }
  static ProductDetailsBloc get(context)=>BlocProvider.of(context);

  GetProductDetailsUseCase getProductDetailsUseCase;
  GetChangeOfProductDetailsUseCase getChangeOfProductDetailsUseCase;
  GetProductDynamicVariantsDetailsUseCase getProductDynamicVariantsDetailsUseCase;
  GetProductsUseCase getProductsUseCase;
  SetWishlistItemUseCase setWishlistItemUseCase;
  final AddToCart addToCart;
  NotifyMeUseCase notifyMeUseCase;
int amount=1;
List<int> amountLength=[];
   FutureOr<void> getProductDetails(GetProductDetailsEvent event,Emitter<ProductDetailsStates> emit )async{

    final result=await  getProductDetailsUseCase( GetProductDetailsParams(productId: event.productId));
    result.fold((l) {
      ServerFailure(l.message);

      emit( state.copyWith(productDetailsState: RequestStates.error));

    } , (r) {
      for (int i=0;i<=(r.productModel?.productModel?.amount??0);i++) {
        amountLength.add(i);
      }
      totalPrice=r.productModel?.productModel?.offer??false?r.productModel?.productModel?.offerPrice??0:r.productModel?.productModel?.price??0;
      emit(state.copyWith(productDetailsState: RequestStates.success,productDataModel: r.productModel,totalPrice: r.productModel?.productModel?.offer??false?r.productModel?.productModel?.offerPrice:r.productModel?.productModel?.price));
    } );


  }
   FutureOr<void> getChangeProductVariants(GetChangeProductsVariants event,Emitter<ProductDetailsStates> emit )async{

    final result=await  getChangeOfProductDetailsUseCase(GetChangeOfProductDetailsParams(productCode: event.code, variantValueIds: event.variantValueIds));
    result.fold((l) {
      ServerFailure(l.message);
      emit( state.copyWith(changeProductVariantsState: RequestStates.error,message: l.message));
      showCustomSnackBar(event.context, state.message??"",color: ColorsConstants.red);
    } , (r) {
      sl<ProductDetailsBloc>().add(GetProductsDynamicVariantsEvent(r.productModel?.productModel?.id??0));
      // amountLength.length=r.productModel?.productModel?.amount??0;
      for (int i=0;i<=(r.productModel?.productModel?.amount??0);i++) {
        amountLength.add(i);
      }
      totalPrice=r.productModel?.productModel?.offer??false?r.productModel?.productModel?.offerPrice??0:r.productModel?.productModel?.price??0;

      emit(state.copyWith(changeProductVariantsState: RequestStates.success,productDataModel: r.productModel,message: r.message,totalPrice: r.productModel?.productModel?.offer??false?r.productModel?.productModel?.offerPrice??0:r.productModel?.productModel?.price??0)
    );});

  }
  final List<DynamicVariantModel> dynamicVariantHasAmountModel=[];
  final List<DynamicVariantModel> dynamicVariantHasNoAmountModel=[];
  List<int> counterList=[];

  FutureOr<void> getDynamicVariants(GetProductsDynamicVariantsEvent event,Emitter<ProductDetailsStates> emit)async{
     counterList=[];
      final result=await  getProductDynamicVariantsDetailsUseCase(GetDynamicVariantsProductDetailsParams(productId: event.productId));
      result.fold((l) {
        ServerFailure(l.message);
        emit(state.copyWith(productDynamicVariantsState: RequestStates.error));
      } , (r) {
        r.dynamicVariantModel?.forEach((element) {
          if(element.hasAmount??false){
            counterList.add(0);
          }
        });
        for (var element in r.dynamicVariantModel!) {
          if(element.hasAmount??false){
            dynamicVariantHasAmountModel.add(element);
          }else{
            dynamicVariantHasNoAmountModel.add(element);

          }
          }
        emit(state.copyWith(productDynamicVariantsState: RequestStates.success,dynamicVariantModel: r.dynamicVariantModel,dynamicVariantHasAmountModel:dynamicVariantHasAmountModel ,dynamicVariantHasNoAmountModel:dynamicVariantHasNoAmountModel ));

      });
  }
  FutureOr<void> getSimilarProducts(GetSimilarProductsEvent event,Emitter<ProductDetailsStates> emit) async {
    final res = await getProductsUseCase(
       GetProductsParams(
        offset: 0,
        limit: 10,
        bestSeller: false,
        newIn: false,
        offer: false,
        categoryId: event.categoryId
      ),
    );

    res.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(similarProductsState: RequestStates.error));
    }, (r) {
      emit(state.copyWith(
          similarProductsState: RequestStates.success,
        similarProducts: r.productMetaModel?.products??[]
      ));
    });
  }
  FutureOr<void> setWishlist(SetWishListEvent event,Emitter<ProductDetailsStates> emit)async{
    var token=sl<UserPreferenceRepo>().getAccessToken();
    // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNjkyNTY4MTYzfQ.QJaluvvMH6nHQMSd4Zqk-TdVu2Al67tzWbk5rf80eL4";
    if(token.isEmpty){
      showCustomSnackBar(event.context,StringsConstants.notRegisterYet.tr(),color: ColorsConstants.red);

    }else{

      var result=await setWishlistItemUseCase(SetWishlistItemParams(productID: ProductIdModel(event.productId), token: token));
      result.fold((l) {ServerFailure(l.message);
      showCustomSnackBar(event.context,l.message,color: ColorsConstants.red);

      emit(state.copyWith(setWishListState: RequestStates.error));

      } , (r) {
        emit(state.copyWith(setWishListState: RequestStates.success));
        showCustomSnackBar(event.context,r.message??StringsConstants.addedToWishlist.tr(),color: ColorsConstants.green);

        sl<WishlistCubit>().getWishlists();

      });
    }





  }
   double totalPrice=0;
Map<int,Map<int,double>> dynamicVariantsList={};
isSelected(IsSelectedEvent event,Emitter<ProductDetailsStates> emit){
  emit(state.copyWith(isSelectedState: RequestStates.loading,totalPrice: totalPrice));

  emit(state.copyWith(isSelectedState: RequestStates.success,totalPrice: totalPrice));

}
  addToCounterList(AddToCounterListEvent event,Emitter<ProductDetailsStates> emit){
    // emit(state.copyWith(addToListState: RequestStates.loading));
    // counterList[event.index]++;

emit(state.copyWith(addToListState: RequestStates.success,totalPrice:  event.totalPrice));


  }
  minusFromCounterList(RemoveFromCounterListEvent event,Emitter<ProductDetailsStates> emit){
    // emit(state.copyWith(removeFromListState: RequestStates.loading));

    // counterList[event.index]-=1;

    emit(state.copyWith(removeFromListState: RequestStates.success,totalPrice: event.totalPrice));

  }
  changeQuantityAmount(ChangeQuantityEvent event,Emitter<ProductDetailsStates> emit){

    emit(state.copyWith(changeQuantityState: RequestStates.success,totalPrice: event.totalPrice));

  }
  notifyMe(NotifyMeEvent event,Emitter<ProductDetailsStates> emit)async{
    var token=sl<UserPreferenceRepo>().getAccessToken();
    if(token.isNotEmpty){
      final result=await  notifyMeUseCase(NotifyMeParams(productID:ProductIdModel(event.productId) , token: token));
      result.fold((l) => ServerFailure(l.message), (r) {
        showCustomSnackBar(event.context, state.message??"",color: ColorsConstants.green);

      } );

    }

  }

  Future<void> addProductToCart({required AddToCartBody addToCartBody,required BuildContext context}) async {
    final res = await addToCart(AddToCartParams(addToCartBody: addToCartBody));
    res.fold((l) {
      // showCustomSnackBar(context, l.message,color: ColorsConstants.red);

      if (kDebugMode) {
        print(l);
      }
    }, (r) {
      // showCustomSnackBar(context, StringsConstants.productIsAddedToYourCart.tr(),color: ColorsConstants.green);

      if (kDebugMode) {
        print(r);
      }
    });
  }
  Future<dynamic> productDetailsPopUp(BuildContext context,{required String productName,required double  cartTotalPrice}) {
    return showDialog(
      context: context,
      builder: (context) =>  AddProductPopUpWidget(productName:productName ,cartTotalPrice: cartTotalPrice),
    );
  }
}