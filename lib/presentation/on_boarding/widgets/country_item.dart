import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/common_widgets/checks/check_widget.dart';

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
          SvgPicture.asset(countryFlagPath,width: 25.r,height: 25.r),
        ],
      ),
    );
  }
}
