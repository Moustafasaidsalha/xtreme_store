import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/constants/values_manager.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.s244.h,
      color: ColorsConstants.black,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(StringsConstants.myAccount.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: ColorsConstants.white, letterSpacing: -1.6)),
          SizedBox(
            height: AppSize.s20.h,
          ),
          Text(
            userName,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorsConstants.white.withOpacity(.6),
                ),
          ),
        ],
      ),
    );
  }
}
