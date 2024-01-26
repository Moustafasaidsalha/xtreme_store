import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    Key? key,
    this.backGroundColor ,
    this.foreGroundColor = ColorsConstants.white,
    this.borderColor=Colors.transparent,
    required this.title,
    required this.onPressed,
    this.disabledBackGroundColor = ColorsConstants.semiLightBlack,
    this.disabledForegroundColor,
    this.roundedCorner=10,
    this.borderWidth=0,
    this.textStyle,
  }) : super(key: key);

  final Color? backGroundColor;
  final Color? foreGroundColor;
  final Color? disabledBackGroundColor;
  final Color? disabledForegroundColor;
  final Color? borderColor;
  final String title;
  final double? roundedCorner;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        disabledForegroundColor: disabledForegroundColor,
        disabledBackgroundColor: disabledBackGroundColor,
        backgroundColor: backGroundColor??ColorsConstants.black,

        padding: const EdgeInsets.all(14),
        foregroundColor: foreGroundColor,
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: foreGroundColor,
        ),
        shape:  RoundedRectangleBorder(

          side: BorderSide(width: borderWidth!,color: borderColor!),
          borderRadius: BorderRadius.all(
            Radius.circular(roundedCorner!.r),
          ),
        ),
        // side: BorderSide(
        //   color: borderColor ?? backGroundColor!,
        //   width: borderWidth ?? 0.5,
        //   strokeAlign: BorderSide.strokeAlignInside,
        // ),
      ),
      child: Text(title,style: textStyle,),
    );
  }
}
