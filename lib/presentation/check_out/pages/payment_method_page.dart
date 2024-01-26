import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/data/models/order/add_order_body.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/cart/widgets/total_widget.dart';
import 'package:extreme_store/presentation/check_out/model_view/payment_method_cubit.dart';
import 'package:extreme_store/presentation/check_out/model_view/payment_method_state.dart';
import 'package:extreme_store/presentation/check_out/widgets/address_information_widget.dart';
import 'package:extreme_store/presentation/check_out/widgets/headline_widget.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';

import '../../../app/routes/routes_constants.dart';
import '../../../domain/entity/cart_entity.dart';

class PaymentMethodArgs {
  final int addressID;
  final int cartID;
  final int intervalHourID;
  final String selectedDay;
  final CartEntity cartEntity;
  final bool isAllDigital;

  PaymentMethodArgs({
    required this.addressID,
    required this.cartID,
    required this.intervalHourID,
    required this.cartEntity,
    required this.selectedDay,
    required this.isAllDigital,
  });
}

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key, required this.paymentMethodArgs});
  final PaymentMethodArgs paymentMethodArgs;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentMethodCubit, PaymentMethodStates>(
      listenWhen: (previous, current) {
        return previous.placeOrderStatus != current.placeOrderStatus ||
            previous.orderSummaryStatus != current.orderSummaryStatus;
      },
      listener: (context, state) {
        if (state.orderSummaryStatus == StateStatus.failure) {
          showCustomSnackBar(context, state.message);
        }
        if (state.placeOrderStatus == StateStatus.success) {
          Navigator.of(context).pushNamed(RoutesConstant.paymentPage, arguments: state.url);
        } else if (state.placeOrderStatus == StateStatus.failure) {
          showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            StringsConstants.checkOut.tr(),
          ),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      paymentMethodArgs.isAllDigital
                          ? const SizedBox()
                          : HeadlineWidget(
                              title: StringsConstants.shipTo.tr(),
                              option: StringsConstants.change.tr(),
                              onOptionTaped: () {
                                Navigator.of(context).pushNamed(RoutesConstant.addresses);
                              },
                            ),
                      paymentMethodArgs.isAllDigital ? const SizedBox() : const AddressInformationWidget(),
                      HeadlineWidget(
                        title: StringsConstants.paymentMethod.tr(),
                      ),
                      PaymentMethodWidget(isAllDigital: paymentMethodArgs.isAllDigital),
                      HeadlineWidget(
                        title: StringsConstants.orderSummery.tr(),
                      ),
                      BlocBuilder<PaymentMethodCubit, PaymentMethodStates>(
                        builder: (context, state) {
                          if (state.orderSummaryStatus == StateStatus.success) {
                            return TotalWidget(
                              total: state.orderSummaryDataModel.total ?? 0,
                              subTotal: state.orderSummaryDataModel.subTotal ?? 0,
                              shippingFees: state.orderSummaryDataModel.shippingFee ?? 0,
                              discountAmount: state.orderSummaryDataModel.discountAmount ?? 0,
                              cashOnDelivery: state.orderSummaryDataModel.cashInDelivery ?? 0,
                              numOfItems: paymentMethodArgs.cartEntity.products.length,
                              currency: paymentMethodArgs.cartEntity.currency,
                            );
                          } else if (state.orderSummaryStatus == StateStatus.loading) {
                            return const CustomLoader();
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<PaymentMethodCubit, PaymentMethodStates>(
                  builder: (context, state) {
                    if (state.placeOrderStatus == StateStatus.loading) {
                      return const CustomLoader();
                    } else {
                      return ReusableElevatedButton(
                        title: StringsConstants.placeOrder.tr(),
                        onPressed: () {
                          if (kDebugMode) {
                            print(paymentMethodArgs.cartID);
                            print(paymentMethodArgs.addressID);
                            print(paymentMethodArgs.intervalHourID);
                          }
                          context.read<PaymentMethodCubit>().addOrder(
                                orderBody: AddOrderBody(
                                  paymentMethod: state.paymentMethod.name,
                                  cartID: paymentMethodArgs.cartID,
                                  intervalHourID: paymentMethodArgs.intervalHourID,
                                  userAddressID: paymentMethodArgs.addressID,
                                  day: paymentMethodArgs.selectedDay,
                                ),
                                isAllDigital: paymentMethodArgs.isAllDigital,
                              );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 28.r),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
    required this.isAllDigital,
  });

  final bool isAllDigital;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodCubit, PaymentMethodStates>(
      builder: (context, state) {
        return Container(
          decoration: ShapeDecoration(
            color: ColorsConstants.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                PaymentMethodItemWidget(
                  title: StringsConstants.online.tr(),
                  isSelect: state.paymentMethod == PaymentMethods.visa,
                  methods: PaymentMethods.visa,
                  iconsPaths: const [
                    IconsConstants.visaIcon,
                    IconsConstants.masterCardIcon,
                    IconsConstants.knetIcon,
                  ],
                ),
                isAllDigital ? const SizedBox() : const SizedBox(height: 20),
                isAllDigital
                    ? const SizedBox()
                    : PaymentMethodItemWidget(
                        title: StringsConstants.cashOnDelivery.tr(),
                        isSelect: state.paymentMethod == PaymentMethods.cash,
                        methods: PaymentMethods.cash,
                        iconsPaths: const [IconsConstants.cashOnDelivery],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentMethodItemWidget extends StatelessWidget {
  const PaymentMethodItemWidget({
    super.key,
    required this.isSelect,
    required this.title,
    required this.methods,
    required this.iconsPaths,
  });

  final bool isSelect;
  final String title;
  final PaymentMethods methods;
  final List<String> iconsPaths;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.15,
            color: ColorsConstants.gray,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: GestureDetector(
          onTap: () {
            context.read<PaymentMethodCubit>().changeMethod(method: methods);
          },
          child: Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelect ? ColorsConstants.gray : Colors.transparent,
                  border: Border.all(
                    color: ColorsConstants.gray,
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                  child: Text(
                title,
                style: Theme.of(context).textTheme.displaySmall,
              )),
              Row(
                children: iconsPaths
                    .map(
                      (e) => SizedBox(height: 30, width: 40, child: SvgPicture.asset(e)),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
