import 'package:config/config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/constants/colors_constants.dart';
import '../../../../app/constants/icon_constants.dart';
import '../../../../app/constants/strings_constants.dart';
import '../../../../app/constants/values_manager.dart';
import '../../../../app/utilities/country_utility.dart';
import '../../../common_widgets/checks/check_widget.dart';
import '../../../my_account/widgets/account_list_item.dart';
import '../../model_view/add_new_address_bloc/add_new_address_bloc.dart';
import '../../model_view/add_new_address_bloc/add_new_address_event.dart';
import '../../model_view/add_new_address_bloc/add_new_address_state.dart';

class CountrySelectionWidget extends StatelessWidget {
  const CountrySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState, int>(
      selector: (state) => state.currentCountryID,
      builder: (context, state) {
        return AccountListItem(
          items: StringsConstants.country.tr(),
          onTap: isGCCApp
              ? () async {
            int cID = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SelectCounty(
                currentCounty: state,
              ),
            );
            // ignore: use_build_context_synchronously
            context.read<AddNewAddressBloc>().add(ChangeCountry(countryID: cID));
          }
              : () {},
          postfixWidget: SizedBox(
            height: 26.h,
            width: 38.w,
            child: SvgPicture.asset(
              CountryUtility.countriesDataList
                  .firstWhere(
                    (element) => element.id == state,
              )
                  .iconPath
            ),
          ),
        );
      },
    );
  }
}


class SelectCounty extends StatelessWidget {
  const SelectCounty({super.key, required this.currentCounty});
  final int currentCounty;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: ColorsConstants.white,
      content: SizedBox(
        width: 0.9.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  StringsConstants.selectCountry.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(currentCounty);
                  },
                  child: SvgPicture.asset(IconsConstants.closeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                )
              ],
            ),
            SizedBox(
              height: 44.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: CountryUtility.countriesDataList.length,
              itemBuilder: (context, index) {
                bool isSelected = currentCounty == CountryUtility.countriesDataList[index].id;

                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(
                      CountryUtility.countriesDataList[index].id,
                    );
                  },
                  child: CountryItem(
                    countryName: CountryUtility.countriesDataList[index].nameAR,
                    countryFlagPath: CountryUtility.countriesDataList[index].iconPath,
                    isSelected: isSelected,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
            )
          ],
        ),
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem({
    super.key,
    required this.countryName,
    required this.countryFlagPath,
    required this.isSelected,
  });

  final String countryName;
  final String countryFlagPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PaddingValues.p12.h),
      child: Row(
        children: [
          CheckWidget(isSelected: isSelected),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingValues.p18.w),
            child: Text(
              countryName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(width: 10.w),
          SvgPicture.asset(countryFlagPath, height: 25.h, width: 25.w)
        ],
      ),
    );
  }
}
