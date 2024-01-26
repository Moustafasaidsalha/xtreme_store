import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';

class HeadlineWidget extends StatelessWidget {
  const HeadlineWidget({
    super.key,
    required this.title,
    this.option,
    this.onOptionTaped,
  });

  final String title;
  final String? option;
  final VoidCallback? onOptionTaped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 14.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (option != null)
            GestureDetector(
              onTap: onOptionTaped,
              child: Text(
                StringsConstants.change.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
