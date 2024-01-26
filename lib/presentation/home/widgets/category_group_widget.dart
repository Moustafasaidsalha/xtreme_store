import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';

class CategoryGroupWidget extends StatelessWidget {
  const CategoryGroupWidget({
    required this.categoryName,
    required this.categoryImage,
    super.key,
  });
final String categoryName;
final String categoryImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsConstants.white,
      height: 85.h,
      width: 113.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.h,
              // width: 40.w,
              child: Image.network(categoryImage, errorBuilder: (context, error, stackTrace) => Container(
                child: SvgPicture.asset(IconsConstants.placeholder),
              ),)),
          SizedBox(
            height: 10.h,
          ),
          Text(
            categoryName,
            maxLines: 1,overflow:TextOverflow.ellipsis ,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: ColorsConstants.black1,
                  fontSize: FontSize.s14.sp,
              overflow: TextOverflow.ellipsis,

                ),
          )
        ],
      ),
    );
  }
}
