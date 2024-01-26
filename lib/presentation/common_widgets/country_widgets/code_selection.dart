import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/icon_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/utilities/country_utility.dart';
import '../../authentication/widgets/country_code_item.dart';

class CodeSelectionWidget extends StatelessWidget {
  final String currentCountyCode;
  final Function(int) onPressed;

  const CodeSelectionWidget({
    super.key,
    required this.currentCountyCode,
    required this.onPressed,
  });

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
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(IconsConstants.closeCircleIC),
                )
              ],
            ),
            SizedBox(height: 40.w),
            ListView.separated(
              shrinkWrap: true,
              itemCount: CountryUtility.countriesDataList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                bool isSelected = currentCountyCode == CountryUtility.countriesDataList[index].code;
                return InkWell(
                  onTap: (){
                    onPressed(index);
                    Navigator.pop(context);
                  },
                  // onTap: () {
                  //   context.read<LoginBloc>().add(CountryChanged(
                  //     countryDataModel: CountryUtility.countriesDataList[index],
                  //   ));
                  //   Navigator.of(context).pop();
                  // },
                  child: CountryCodeItem(
                    isSelected: isSelected,
                    countryFlagPath: CountryUtility.countriesDataList[index].iconPath,
                    countryName: CountryUtility.countriesDataList[index].nameAR,
                    countryCode: CountryUtility.countriesDataList[index].code,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: ColorsConstants.gray.withOpacity(0.15),
              ),
            )
          ],
        ),
      ),
    );
  }
}