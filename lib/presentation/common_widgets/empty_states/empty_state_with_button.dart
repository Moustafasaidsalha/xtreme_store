import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';

class EmptyStateWithButton extends StatelessWidget {
  const EmptyStateWithButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.onTap,
  });
  final String icon;
  final String title;
  final String subTitle;
  final String buttonText;
  final VoidCallback onTap;

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
                  color: ColorsConstants.lightGrey,
                  fontSize: FontSize.s18,
                  height: AppSize.s1_5.sp),
              textAlign: TextAlign.center,
            )),
        SizedBox(
          height: 18.r,
        ),
        ReusableElevatedButton(
          title: buttonText,
          onPressed: onTap,
          roundedCorner: 30,
          backGroundColor: ColorsConstants.blue,
        ),
      ],
    );
  }
}
