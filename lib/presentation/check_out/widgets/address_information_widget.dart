import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_states.dart';
import 'package:extreme_store/presentation/check_out/model_view/payment_method_cubit.dart';
import 'package:extreme_store/presentation/check_out/widgets/address_information_item.dart';

class AddressInformationWidget extends StatelessWidget {
  const AddressInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: ColorsConstants.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: BlocConsumer<AddressSelectionCubit, AddressSelectionStates>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is SuccessAddressSelection) {
              final addressModel = state.listOfAddresses.firstWhere((element) => (element.isDefault ?? false));
              context.read<PaymentMethodCubit>().changeAddress(addressID: addressModel.id ?? 0);
            }
          },
          builder: (context, state) {
            // final state = context.watch<AddressSelectionCubit>().state;
            if (state is SuccessAddressSelection) {
              final addressModel = state.listOfAddresses.firstWhere((element) => (element.isDefault ?? false));
              return Column(
                children: [
                  // InformationItem(
                  //   title: StringsConstants.name.tr(),
                  //   value: "Assem khalifa",
                  // ),
                  InformationItem(
                    title: StringsConstants.address.tr(),
                    value: addressModel.addressName ?? '',
                  ),
                  PhoneItem(
                    title: StringsConstants.phoneNumber.tr(),
                    value: "${addressModel.userPhoneAddressModel?.countryCode ?? ''} "
                        "${addressModel.userPhoneAddressModel?.phone ?? ''}",
                    isPhoneVareified: true,
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class PhoneItem extends StatelessWidget {
  const PhoneItem({
    super.key,
    required this.title,
    required this.value,
    this.isPhoneVareified,
  });

  final String title;
  final String value;
  final bool? isPhoneVareified;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                ),
                const SizedBox(width: 4),
                isPhoneVareified != null
                    ? Expanded(
                        child: Text(
                          StringsConstants.verified.tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorsConstants.green),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
