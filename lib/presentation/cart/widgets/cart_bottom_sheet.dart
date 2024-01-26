import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/domain/entity/cart_entity.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_states.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';

import '../../../app/routes/routes_constants.dart';
import '../../check_out/pages/payment_method_page.dart';
import '../../check_out/pages/time_slot_page.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({
    super.key,
    required this.itemLength,
    required this.total,
    required this.currency,
    required this.cartID,
    required this.cartEntity,
  });

  final int itemLength;
  final double total;
  final String currency;
  final int cartID;
  final CartEntity cartEntity;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddressSelectionCubit>().state;
    return Container(
      height: 130.r,
      decoration: const ShapeDecoration(
        color: ColorsConstants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$itemLength Items',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorsConstants.gray,
                      ),
                ),
                Text(
                  '$total $currency',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorsConstants.gray,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ReusableElevatedButton(
              title: StringsConstants.checkOut.tr(),
              onPressed: () {
                bool isRegisteredUser = context.read<CartCubit>().isRegisteredUser();
                bool isAllDigital = context.read<CartCubit>().checkIfAllDigital();
                if (isAllDigital) {
                  if (isRegisteredUser) {
                    Navigator.of(context).pushNamed(RoutesConstant.paymentMethod,
                        arguments: PaymentMethodArgs(
                          addressID: 0,
                          cartID: cartID,
                          cartEntity: cartEntity,
                          intervalHourID: 0,
                          selectedDay: '',
                          isAllDigital: true
                        ));
                  } else {
                    showCustomSnackBar(context, StringsConstants.pleaseLoginToYourAccount.tr());
                  }
                } else if (state is SuccessAddressSelection) {
                  if (state.listOfAddresses.isNotEmpty) {
                    int id = state.listOfAddresses.firstWhere((element) => (element.isDefault ?? false)).id ?? 0;

                    if (kDebugMode) {
                      print("change addressID $id");
                    }
                    Navigator.of(context).pushNamed(
                      RoutesConstant.timeSlot,
                      arguments: TimeSlotArgs(addressID: id, cartID: cartID, cartEntity: cartEntity),
                    );
                  } else {
                    showCustomSnackBar(context, StringsConstants.selectYourAddress.tr());
                  }
                } else {
                  showCustomSnackBar(context, StringsConstants.selectYourAddress.tr());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
