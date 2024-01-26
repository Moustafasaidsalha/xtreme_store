import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_outlined_button.dart';

class EmptyStatesWidget extends StatelessWidget {
  const EmptyStatesWidget({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.buttonTitle,
    required this.buttonHeight,
    required this.buttonColor,
    required this.buttonMargin,
    required this.buttonRadius,
    required this.buttonTextColor,
    required this.spaceBetweenSubtitleAndButton,
    required this.onPressed,
    super.key,
  });
  final String icon;
  final String title;
  final String subTitle;
  final String buttonTitle;
  final double buttonHeight;
  final double spaceBetweenSubtitleAndButton;
  final Color buttonColor;
  final double buttonMargin;
  final double buttonRadius;
  final Color buttonTextColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSize.s56.h,
        ),
        SvgPicture.asset(icon),
        SizedBox(
          height: AppSize.s30.h,
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
        SizedBox(
          height: spaceBetweenSubtitleAndButton.h,
        ),
        MainButton(
            margin: buttonMargin,
            height: buttonHeight,
            radius: buttonRadius,
            onPressed: onPressed,
            color: buttonColor,
            text: buttonTitle,
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: buttonTextColor, fontSize: FontSize.s18))
      ],
    );
  }
}
