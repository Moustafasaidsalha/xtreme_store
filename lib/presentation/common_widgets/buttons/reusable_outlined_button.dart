import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableOutlinedButton extends StatelessWidget {
  ReusableOutlinedButton({
    Key? key,
    this.backGroundColor,
    this.foreGroundColor,
    this.borderColor,
    required this.title,
    required this.onPressed,
    this.disabledBackGroundColor,
    this.disabledForegroundColor,
    this.textStyle,
    this.roundedCorner = 5,
    this.borderWidth,
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
  TextStyle? textStyle = TextStyle();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        disabledForegroundColor: disabledForegroundColor,
        disabledBackgroundColor: disabledBackGroundColor,
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.all(14),
        foregroundColor: foreGroundColor,
        // textStyle: context
        //     .getlabelMediumStyle()
        //     ?.copyWith(color: Theme.of(context).lightBackGround, fontSize: 13.5.toValue(context)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(roundedCorner ?? 5),
          ),
        ),
        side: BorderSide(
          color: borderColor ?? backGroundColor!,
          width: borderWidth ?? 0.5,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

// class FixedReusableOutlinedButton extends StatelessWidget {
//   const FixedReusableOutlinedButton({
//     Key? key,
//     this.backGroundColor = ColorsManager.brown,
//     this.foreGroundColor = ColorsManager.lightBackGround,
//     this.borderColor,
//     required this.title,
//     required this.onPressed,
//     this.disabledBackGroundColor,
//     this.disabledForegroundColor,
//     this.roundedCorner,
//     this.borderWidth,
//   }) : super(key: key);
//
//   final Color? backGroundColor;
//   final Color? foreGroundColor;
//   final Color? disabledBackGroundColor;
//   final Color? disabledForegroundColor;
//   final Color? borderColor;
//   final String title;
//   final double? roundedCorner;
//   final double? borderWidth;
//   final VoidCallback? onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: onPressed,
//       style: OutlinedButton.styleFrom(
//         disabledForegroundColor: disabledForegroundColor,
//         disabledBackgroundColor: disabledBackGroundColor,
//         backgroundColor: backGroundColor,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         foregroundColor: foreGroundColor,
//         textStyle: Theme.of(context)
//             .textTheme
//             .labelSmall
//             ?.copyWith(color: Theme.of(context).lightBackGround, fontSize: 12.0.toValue(context)),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(roundedCorner ?? ConstantsManager.kRoundedBorder),
//           ),
//         ),
//         side: BorderSide(
//           color: borderColor ?? backGroundColor!,
//           width: borderWidth ?? 0.5,
//           strokeAlign: BorderSide.strokeAlignInside,
//         ),
//       ),
//       child: Text(title),
//     );
//   }
// }

class MainButton extends StatelessWidget {
  MainButton({
    super.key,
    required this.margin,
    required this.height,
    required this.radius,
    required this.onPressed,
    required this.color,
    required this.text,
    required this.textStyle,
  });
  final VoidCallback onPressed;

  double margin = 20.w;
  double height = 152.h;
  double radius = 152.h;
  Color color = Colors.black;

  String text = "";
  TextStyle textStyle = TextStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.h,
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius.r)),
          ),
          onPressed: onPressed,
          child: Center(
            child: Text(
              text,
              style: textStyle,
            ),
          )),
    );
  }
}
