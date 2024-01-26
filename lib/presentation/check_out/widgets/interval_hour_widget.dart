import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';

import '../../../app/constants/colors_constants.dart';

class IntervalHourWidget extends StatelessWidget {
  final String from;
  final String to;
  final bool isSelected;
  final bool isAvailable;
  const IntervalHourWidget({
    super.key,
    required this.from,
    required this.to,
    required this.isSelected,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: isAvailable
            ? isSelected
                ? ColorsConstants.black
                : ColorsConstants.white
            : ColorsConstants.lightGray.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Text(
            '${StringsConstants.from.tr()} $from ${StringsConstants.to.tr()} $to',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: isAvailable
                      ? isSelected
                          ? ColorsConstants.white
                          : ColorsConstants.black3
                      : ColorsConstants.gray1,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
