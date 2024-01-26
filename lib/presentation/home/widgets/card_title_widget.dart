import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';

class CardTitleWidget extends StatelessWidget {
  const CardTitleWidget({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                StringsConstants.viewAll.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorsConstants.black,
                      fontSize: FontSize.s12.sp,
                    ),
              ),
              SizedBox(
                width: AppSize.s5.w,
              ),
              Transform.flip(
                  flipX:isAr?true:false,
                  child: SvgPicture.asset(IconsConstants.arrowRightIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)))
            ],
          ),
        )
      ],
    );
  }
}
