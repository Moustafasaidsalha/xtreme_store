import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/icon_constants.dart';
import '../../../app/utilities/country_utility.dart';

class PhonePrefixWidget extends StatelessWidget {
  final CountryDataModel countryDataModel;
  const PhonePrefixWidget({
    super.key,
    required this.countryDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            countryDataModel.iconPath,
            height: 20.w,
            width: 20.w,
          ),
          SizedBox(width: 4.r),
          SvgPicture.asset(IconsConstants.arrowDownIC),
          SizedBox(width: 6.r),
          SizedBox(
            width: 2,
            height: 30.r,
            child: Container(color: ColorsConstants.darkerGray),
          ),
          SizedBox(width: 6.r),
          Text(countryDataModel.code),
        ],
      ),
    );
  }
}
