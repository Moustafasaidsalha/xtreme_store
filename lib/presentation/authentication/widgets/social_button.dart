import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    required this.backGroundColor,
    required this.foreGroundColor,
    required this.borderColor,
  }) : super(key: key);

  final String title;
  final String imagePath;
  final VoidCallback? onPressed;
  final Color backGroundColor;
  final Color foreGroundColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        // textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
        //       fontSize: FontSize.s20,
        //     ),
        // shadowColor: ColorsManager.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Opacity(
            //   opacity: 0,
            //   child: SvgPicture.asset(ImagesManager.googleIcon),
            // ),
            SvgPicture.asset(imagePath, height: 24),
            const SizedBox(width: 25),
            Text(title),
          ],
        ),
      ),
    );
  }
}
