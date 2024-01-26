import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/icon_constants.dart';
import '../../../app/constants/values_manager.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    super.key,
    required this.items,
    required this.onTap,
    this.itemColor ,
    this.postfixWidget = const SizedBox(),
  });

  final String items;
  final Color? itemColor;
  final VoidCallback onTap;
  final Widget postfixWidget;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSize.s56.h,
        padding: EdgeInsets.symmetric(horizontal: PaddingValues.p16.w),
        decoration: BoxDecoration(
          color: ColorsConstants.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          children: [
            Text(items,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: itemColor??ColorsConstants.black,
                )),
            const Spacer(),
            postfixWidget,
            Transform.flip(
              flipX: isAr ? true : false,
              child: SvgPicture.asset(IconsConstants.arrowRightWideIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
            ),
          ],
        ),
      ),
    );
  }
}
