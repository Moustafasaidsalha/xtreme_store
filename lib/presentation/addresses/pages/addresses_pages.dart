import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/data/models/addresses_response_model.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_states.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';

import '../../common_widgets/empty_states/empty_state_with_button.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithActionButton(title: StringsConstants.addresses.tr()),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: BlocConsumer<AddressSelectionCubit, AddressSelectionStates>(
            listenWhen: (previous, current) {
              return current is FailureAddressSelection;
            },
            listener: (context, state) {
              if (state is FailureAddressSelection) {
                showCustomSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is SuccessAddressSelection) {
                return state.listOfAddresses.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return AddressItemWidget(
                                  addressModel: state.listOfAddresses[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 12.r);
                              },
                              itemCount: state.listOfAddresses.length,
                            ),
                          ),
                          SizedBox(height: 28.r),
                          Row(
                            children: [
                              Expanded(
                                child: ReusableElevatedButton(
                                  title: StringsConstants.addNewAddress.tr(),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(RoutesConstant.mapPage);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 28.r),
                        ],
                      )
                    : EmptyStateWithButton(
                        icon: IconsConstants.noAddressIC,
                        title: StringsConstants.noAddressYetTitle.tr(),
                        subTitle: StringsConstants.noAddressYetSubTitle.tr(),
                        buttonText: StringsConstants.addAddress.tr(),
                        onTap: () {
                          Navigator.of(context).pushNamed(RoutesConstant.mapPage);
                        },
                      );
              } else if (state is LoadingAddressSelection) {
                return const Center(child: CustomLoader());
              } else if (state is LoadingAddressSelection) {
                return const Center(child: Text("Error"));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    super.key,
    required this.addressModel,
  });

  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: ColorsConstants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 12.h,
            ),
            child: Row(
              children: [
                (addressModel.isDefault ?? false) == true
                    ? const DefaultAddressWidget()
                    : SetDefaultAddressWidget(addressModel: addressModel),
                const Spacer(),
                AddressItemHeadButton(
                  addressModel: addressModel,
                  onTap: () {
                    context.read<AddressSelectionCubit>().deleteAddress(
                          addressID: addressModel.id ?? 0,
                        );
                  },
                  iconPath: IconsConstants.trashIC,
                  title: StringsConstants.remove.tr(),
                ),
                // SizedBox(
                //   width: 30.w,
                // ),
                // AddressItemHeadButton(
                //   addressModel: addressModel,
                //   onTap: () {},
                //   title: StringsConstants.edit,
                //   iconPath: IconsConstants.editIC,
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          SizedBox(
            height: 18.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Text(StringsConstants.name,
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodySmall!
                //             .copyWith(fontSize: FontSize.s12)),
                //     SizedBox(
                //       width: 71.w,
                //     ),
                //     Text("Assem Khalifa",
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodySmall!
                //             .copyWith(fontSize: FontSize.s12)),
                //   ],
                // ),
                // SizedBox(
                //   height: 16.h,
                // ),
                Row(
                  children: [
                    Text(StringsConstants.address.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: FontSize.s12)),
                    SizedBox(
                      width: 60.w,
                    ),
                    Expanded(
                      child: Text(addressModel.addressName ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: FontSize.s12)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Text(StringsConstants.phoneNumber.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: FontSize.s12)),
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      "${addressModel.userPhoneAddressModel?.countryCode ?? ''} "
                      "${addressModel.userPhoneAddressModel?.phone ?? ''}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: FontSize.s12,
                          ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      StringsConstants.verified.tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: FontSize.s12,
                            color: ColorsConstants.green,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddressItemHeadButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String iconPath;

  const AddressItemHeadButton({
    super.key,
    required this.addressModel,
    required this.onTap,
    required this.title,
    required this.iconPath,
  });

  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontSize.s12,
                ),
          )
        ],
      ),
    );
  }
}

class SetDefaultAddressWidget extends StatelessWidget {
  const SetDefaultAddressWidget({
    super.key,
    required this.addressModel,
  });

  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AddressSelectionCubit>().changeDefaultAddress(
              addressID: addressModel.id ?? 0,
            );
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                border: Border.all(color: ColorsConstants.semiBlack)),
            child: CircleAvatar(
              radius: 7.r,
              backgroundColor: ColorsConstants.white,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
           Text(StringsConstants.setDefaultAddress.tr())
        ],
      ),
    );
  }
}

class DefaultAddressWidget extends StatelessWidget {
  const DefaultAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(IconsConstants.locationIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
        SizedBox(
          width: 8.w,
        ),
        Text(
          StringsConstants.defaultAddress.tr(),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12),
        )
      ],
    );
  }
}

// Row(
//   children: [
//     Expanded(
//         child: ReusableOutlinedButton(
//       title: StringsConstants.addNewAddress,
//       onPressed: () {
//         Navigator.of(context).pushNamed(RoutesConstant.mapPage);
//       },
//       backGroundColor: ColorsConstants.backGround,
//       foreGroundColor: ColorsConstants.black,
//       borderWidth: 0.25.w,
//       borderColor: ColorsConstants.semiBlack,
//       roundedCorner: 10.r,
//     )),
//   ],
// ),
