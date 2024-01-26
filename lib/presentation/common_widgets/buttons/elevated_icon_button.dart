import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    Key? key,
    required this.backGroundColor ,
    this.foreGroundColor = ColorsConstants.white,
    required this.title,
    required this.onPressed,
    required this.iconPath,
  }) : super(key: key);

  final Color? backGroundColor;
  final Color? foreGroundColor;

  final String title;

  final VoidCallback? onPressed;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(100.r, 30.r),
        elevation: 0,
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        foregroundColor: foreGroundColor,
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: foreGroundColor,
            ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      child: title.isEmpty
          ? Row(
              children: [
                SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
              ],
            )
          : Row(
              children: [
                SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                const SizedBox(width: 5),
                Text(title),
              ],
            ),
    );
  }
}
