import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/cart/widgets/coupon_text_field.dart';
import 'package:extreme_store/presentation/common_widgets/checks/check_widget.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';

import '../model_view/cart_states.dart';

class CouponWidget extends StatefulWidget {
  final int cartID;
  final String couponName;
  const CouponWidget({
    super.key,
    required this.cartID,
    required this.couponName,
  });

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  late TextEditingController _couponTextFiled;
  @override
  void initState() {
    _couponTextFiled = TextEditingController(text: widget.couponName);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CouponWidget oldWidget) {
    if (oldWidget.couponName != widget.couponName && widget.couponName.isEmpty) {
      _couponTextFiled = TextEditingController(text: '');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit,CartSate>(
      listenWhen: (previous, current) {
        return previous.couponState != current.couponState;
      },
      listener: (context, state) {
        if(state.couponState == CouponState.userNotDefined){
          showCustomSnackBar(context, "please login to proceed");
        }
      },
      child: BlocBuilder<CartCubit, CartSate>(
        buildWhen: (previous, current) {
          return previous.couponState != current.couponState;
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
            child: CouponTextField(
              textEditingController: _couponTextFiled,
              isEnabled: true,
              hintText: StringsConstants.enterCouponCode.tr(),
              fillColor: state.couponState == CouponState.unValid
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.gray4,
              onChange: (value) {
                if (state.couponState == CouponState.unValid && value.isEmpty) {
                  context.read<CartCubit>().clearInvalidCoupon();
                }
              },
              suffixWidget: state.couponState == CouponState.unValid
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(state.couponMessage,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: ColorsConstants.red,
                                  )),
                        ),
                      ],
                    )
                  : state.couponState == CouponState.valid
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<CartCubit>().removePromoCodeFromCart(
                                      cartID: widget.cartID,
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CheckWidget(
                                      isSelected: true,
                                      backgroundColor: ColorsConstants.green,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(StringsConstants.remove.tr(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: ColorsConstants.red,
                                            )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<CartCubit>().addPromoCodeToCart(
                                      promoCodeName: _couponTextFiled.text,
                                      cartID: widget.cartID,
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  StringsConstants.apply.tr(),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
