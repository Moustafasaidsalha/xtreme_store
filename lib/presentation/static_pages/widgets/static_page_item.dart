import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';

import '../../../app/constants/fonts_constants.dart';
import '../../../app/constants/icon_constants.dart';

class StaticPageItem extends StatelessWidget {
  const StaticPageItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsConstants.solidCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
            SizedBox(width: 7.w),
            HtmlWidget(
              title,
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: 7.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: HtmlWidget(
            subTitle,
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: FontSize.s14,
                  letterSpacing: -.70,
                  height: 3.h,
                ),
          ),
        ),
      ],
    );
  }
}
