import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/icon_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/routes/routes_constants.dart';
import '../model_view/address_selection_cubit/address_selection_cubit.dart';
import '../model_view/address_selection_cubit/address_selection_states.dart';

class AddressSelectionWidget extends StatelessWidget {
  final Color backgroundColor;
  const AddressSelectionWidget({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressSelectionCubit, AddressSelectionStates>(
      builder: (context, state) {
        if (state is SuccessAddressSelection) {
          return state.listOfAddresses.isEmpty
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesConstant.addresses);
                  },
                  child: Text(
                    StringsConstants.addNewAddress.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorsConstants.blue,
                        ),
                  ))
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesConstant.addresses);
                  },
                  child: Container(
                    height: 40.0.h,
                    alignment: Alignment.center,
                    child: Container(
                      decoration: ShapeDecoration(
                        color: backgroundColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.r),
                              child: SvgPicture.asset(IconsConstants.locationIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                            ),
                            Expanded(
                              child: Text(
                                "${StringsConstants.deliverTo.tr()} ${state.listOfAddresses.firstWhere((element) => element.isDefault ?? false).addressName}",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: ColorsConstants.black,
                                      overflow: TextOverflow.ellipsis,
                                      height: 1,
                                    ),
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.r),
                              child: SvgPicture.asset(IconsConstants.arrowDownIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        } else if (state is NoUserFoundAddressSelection) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesConstant.loginWithPin,
                  (route) => false,
                );
              },
              child: Text(
                StringsConstants.addNewAddress.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorsConstants.blue,
                    ),
              ));
        } else if (state is LoadingAddressSelection) {
          return const CupertinoActivityIndicator();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
