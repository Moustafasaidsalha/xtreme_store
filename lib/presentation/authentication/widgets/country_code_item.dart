import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/constants/values_manager.dart';
import '../../common_widgets/checks/check_widget.dart';

class CountryCodeItem extends StatelessWidget {
  const CountryCodeItem({
    super.key,
    required this.countryName,
    required this.countryFlagPath,
    required this.isSelected,
    required this.countryCode,
  });

  final String countryName;
  final String countryFlagPath;
  final String countryCode;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PaddingValues.p12.r),
      child: Row(
        children: [
          CheckWidget(isSelected: isSelected),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingValues.p18.r),
            child: Text(
              countryName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            countryCode,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(width: 10.r),
          SvgPicture.asset(countryFlagPath,height: 25.r,width: 25.r)
        ],
      ),
    );
  }
}

