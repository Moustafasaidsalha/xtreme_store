import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';
import 'package:extreme_store/domain/entity/cart_entity.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_promo_code.dart';
import 'package:extreme_store/domain/uses_cases/cart/change_product_cart_amount.dart';
import 'package:extreme_store/domain/uses_cases/cart/delete_from_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/get_cart_products.dart';
import 'package:extreme_store/domain/uses_cases/cart/remove_promo_code.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_states.dart';

import '../../../app/di/injection_container.dart';
import '../../../app/failure/failure.dart';
import '../../layout/model_view/layout_cubit.dart';

class CartCubit extends Cubit<CartSate> {
  CartCubit({
    required this.getCartProducts,
    required this.deleteFromCart,
    required this.changeProductCartAmount,
    required this.addPromoCode,
    required this.removePromoCode,
    required this.userPreferenceRepo,
  }) : super(const CartSate());
  final GetCartProducts getCartProducts;
  final DeleteFromCart deleteFromCart;
  final ChangeProductCartAmount changeProductCartAmount;
  final AddPromoCode addPromoCode;
  final RemovePromoCode removePromoCode;
  final UserPreferenceRepo userPreferenceRepo;
   List<SubCarts> products=[];
  static CartCubit get(context) => BlocProvider.of(context);

  Future<void> getCartItems() async {
    if(state.status == StateStatus.initial){
      emit(state.copyWith(status: StateStatus.loading));
    }
    final res = await getCartProducts(NoParams());
    res.fold(
      (l) {
        if (l is DataFailure) {
          emit(state.copyWith(
            status: StateStatus.success,
            cartEntity: const CartEntity(),
            changeState: StateStatus.initial,
          ));
        } else {
          emit(state.copyWith(status: StateStatus.failure));
        }
      },
      (r) {
        sl<LayoutCubit>().isNotEmpty=r.products.isNotEmpty;
        emit(
          state.copyWith(
            status: StateStatus.success,
            cartEntity: r,
            changeState: StateStatus.initial,
            couponState: r.couponName.isNotEmpty ? CouponState.valid : CouponState.initial,
            couponName: r.couponName,
          ),
        );
      },
    );
  }

  Future<void> deleteItemFromCart({required int productID}) async {
    emit(state.copyWith(changeState: StateStatus.loading, message: ''));
    final res = await deleteFromCart(DeleteFromCartParams(productID: productID));
    res.fold(
      (l) {
        emit(state.copyWith(
          changeState: StateStatus.failure,
          message: l.message,
        ));
      },
      (r) async {
        if (r) await getCartItems();
      },
    );
  }

  Future<void> addProductAmount({required SubCarts model}) async {
    emit(state.copyWith(changeState: StateStatus.loading));
    int amount = model.amount ?? 1;
    int maxAmount = model.product?.amount ?? 1;
    if (amount < maxAmount) {
      amount += 1;
      await changeProductAmount(productID: model.productId ?? 0, amount: amount);
    }
  }

  Future<void> minProductAmount({required SubCarts model}) async {
    emit(state.copyWith(changeState: StateStatus.loading));
    int amount = model.amount ?? 1;
    if (amount > 1) {
      amount -= 1;
      await changeProductAmount(productID: model.productId ?? 0, amount: amount);
    }
  }

  Future<void> changeProductAmount({
    required int productID,
    required int amount,
  }) async {
    final res = await changeProductCartAmount(ChangeProductCartAmountParams(
      productID: productID,
      amount: amount,
    ));
    res.fold(
      (l) {
        emit(state.copyWith(
          changeState: StateStatus.failure,
          message: l.message,
        ));
      },
      (r) async {
        await getCartItems();
      },
    );
  }

  Future<void> addPromoCodeToCart({
    required String promoCodeName,
    required int cartID,
  }) async {
    emit(state.copyWith(
      changeState: StateStatus.loading,
      couponState: CouponState.initial,
    ));
    final res = await addPromoCode(
      AddPromoCodeParams(
        promoCodeName: promoCodeName,
        cartID: cartID,
      ),
    );
    res.fold(
      (l) {
        if (l is UserNotFoundFailure) {
          emit(state.copyWith(
            couponState: CouponState.userNotDefined,
            changeState: StateStatus.initial,
            couponMessage: l.message,
          ));
        } else {
          emit(state.copyWith(
            couponState: CouponState.unValid,
            changeState: StateStatus.initial,
            couponMessage: l.message,
          ));
        }
      },
      (r) {
        if (userPreferenceRepo.getAccessToken().isEmpty) {
          double subtotal = state.cartEntity.subTotal;
          double discount = 0;
          double total = 0;
          if (r.promoCodeDataModel?.couponType == 'percentage') {
             discount = (state.cartEntity.subTotal * (r.promoCodeDataModel?.couponValue ?? 1)) / 100;
             total = subtotal - discount;

          }else if(r.promoCodeDataModel?.couponType == 'value'){
            discount = r.promoCodeDataModel?.couponValue ?? 0;
            total = subtotal - discount;
          }
          emit(state.copyWith(
              couponState: CouponState.valid,
              changeState: StateStatus.initial,
              cartEntity: CartEntity(
                products: state.cartEntity.products,
                currency: state.cartEntity.currency,
                coupon: discount,
                subTotal: state.cartEntity.subTotal,
                total: total,
                couponName: promoCodeName,
                shippingFees: state.cartEntity.shippingFees,
              )));
        } else {
          emit(state.copyWith(
            couponState: CouponState.valid,
            changeState: StateStatus.initial,
          ));
          getCartItems();
        }
      },
    );
  }

  Future<void> removePromoCodeFromCart({
    required int cartID,
  }) async {
    emit(state.copyWith(changeState: StateStatus.loading));
    if (userPreferenceRepo.getAccessToken().isEmpty) {
      emit(state.copyWith(
          changeState: StateStatus.success,
          couponState: CouponState.initial,
          couponName: '',
          cartEntity: CartEntity(
            products: state.cartEntity.products,
            coupon: 0,
            total: state.cartEntity.subTotal,
            subTotal: state.cartEntity.subTotal,
            shippingFees: state.cartEntity.shippingFees,
            couponName: '',
            currency: state.cartEntity.currency,
          )));
    } else {
      final res = await removePromoCode(RemovePromoCodeParams(cartID: cartID));
      res.fold(
        (l) {
          emit(state.copyWith(
            changeState: StateStatus.failure,
            message: l.message,
          ));
        },
        (r) {
          emit(
            state.copyWith(
              changeState: StateStatus.success,
              couponState: CouponState.initial,
              couponName: '',
            ),
          );
          getCartItems();
        },
      );
    }
  }

  Future<void> clearInvalidCoupon() async {
    emit(state.copyWith(couponState: CouponState.initial));
  }

  bool checkIfAllDigital(){
    final bool isAllDigital = state.cartEntity.products.every((element) => element.product?.type == "digital");
    return isAllDigital;
  }

  bool isRegisteredUser(){
    final String token = userPreferenceRepo.getAccessToken();
    return token.isEmpty?false:true;
  }
}
