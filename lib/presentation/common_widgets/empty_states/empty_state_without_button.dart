import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';

class EmptyStateWithOutButton extends StatelessWidget {
  const EmptyStateWithOutButton({
    required this.icon,
    required this.title,
    required this.subTitle,
    super.key,
  });
  final String icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(icon),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: AppSize.s30.h,
            ),
          ],
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: FontSize.s28),
        ),
        SizedBox(
          height: AppSize.s8.h,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: MarginValues.m30),
            child: Text(
              subTitle,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: ColorsConstants.black,
                  fontSize: FontSize.s18,
                  height: AppSize.s1_5.sp),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
