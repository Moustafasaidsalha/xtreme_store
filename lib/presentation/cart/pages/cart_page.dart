import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_states.dart';
import 'package:extreme_store/presentation/cart/widgets/address_widget.dart';
import 'package:extreme_store/presentation/cart/widgets/cart_bottom_sheet.dart';
import 'package:extreme_store/presentation/cart/widgets/cart_item.dart';
import 'package:extreme_store/presentation/cart/widgets/coupon_widget.dart';
import 'package:extreme_store/presentation/cart/widgets/total_widget.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';
import 'package:extreme_store/presentation/common_widgets/empty_states/empty_state_without_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocListener<CartCubit, CartSate>(
          listenWhen: (previous, current) {
            return previous.changeState != current.changeState;
          },
          listener: (context, state) {
            if (state.changeState == StateStatus.failure) {
              showCustomSnackBar(context, state.message);
            }
          },
          child: BlocBuilder<CartCubit, CartSate>(
            builder: (context, state) {
              if (state.status == StateStatus.success) {
                return Row(
                  children: [
                    Text(
                      '${StringsConstants.cart.tr()} ( ${state.cartEntity.products.length} )',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 12),
                    state.changeState == StateStatus.loading
                        ? const CupertinoActivityIndicator()
                        : const SizedBox(),
                  ],
                );
              } else {
                return Text(
                  '${StringsConstants.cart.tr()} ( 0 )',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }
            },
          ),
        ),
        bottom: const AddressWidget(),
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: BlocBuilder<CartCubit, CartSate>(
          builder: (context, state) {
            if (state.status == StateStatus.success) {
              return state.cartEntity.products.isNotEmpty
                  ? ListView(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.cartEntity.products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                              child: CartItem(
                                productModel: state.cartEntity.products[index],
                                currency: state.cartEntity.currency,
                              ),
                            );
                          },
                        ),
                        CouponWidget(
                          cartID: state.cartEntity.cartID,
                          couponName: state.cartEntity.couponName,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                            child: TotalWidget(
                              currency: state.cartEntity.currency,
                              total: state.cartEntity.total,
                              subTotal: state.cartEntity.subTotal,
                              shippingFees: 0,
                              cashOnDelivery: 0,
                              discountAmount: state.cartEntity.coupon,
                              numOfItems: state.cartEntity.products.length,
                            ),
                          ),
                        ),
                        SizedBox(height: 130.r),
                      ],
                    )
                  :  EmptyStateWithOutButton(
                      icon: IconsConstants.emptyCartIC,
                      title: StringsConstants.yourCartIsEmptyTitle.tr(),
                      subTitle: StringsConstants.yourCartIsEmptyTitle.tr(),
                    );
            } else if (state.status == StateStatus.loading) {
              return const Center(child: CustomLoader());
            } else if (state.status == StateStatus.failure) {
              return  EmptyStateWithOutButton(
                icon: IconsConstants.notFoundPageIC,
                title: StringsConstants.pageNotFoundTitle.tr(),
                subTitle: StringsConstants.pageNotFoundTitle.tr(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      bottomSheet: BlocBuilder<CartCubit, CartSate>(
        builder: (context, state) {
          if (state.status == StateStatus.success && state.cartEntity.products.isNotEmpty) {
            return CartBottomSheetWidget(
              total: state.cartEntity.total,
              itemLength: state.cartEntity.products.length,
              currency: state.cartEntity.currency,
              cartID: state.cartEntity.cartID,
              cartEntity: state.cartEntity,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
