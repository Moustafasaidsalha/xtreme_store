import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_outlined_button.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    this.isOffer = false,
    this.isWishlist = false,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.onTap,
    this.removeFromWishlist,
    this.addToCart,
    this.productOfferPrice = 0,
    super.key,
  });
  final bool isOffer;
  final bool isWishlist;
  final String productName;
  final String productImage;
  final double productPrice;
  final double productOfferPrice;
  final Function()? onTap;
  final Function()? removeFromWishlist;
  final VoidCallback? addToCart;
  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Container(
      color: ColorsConstants.white,
      // height: AppSize.s85.h,
      height: isWishlist ? AppSize.s239.h : AppSize.s274,
      width: AppSize.s171.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isWishlist
              ? Padding(
                  padding: EdgeInsets.only(
                      top: AppSize.s10.h,
                      left: AppSize.s10.w,
                      bottom: AppSize.s25.h,
                      right: AppSize.s10.w),
                  child: GestureDetector(
                    onTap: removeFromWishlist,
                    child: Row(
                      children: [
                        SvgPicture.asset(IconsConstants.trashIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                        SizedBox(
                          width: AppSize.s10.w,
                        ),
                        Text(
                          "Remove",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: FontSize.s12.sp),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
          Center(
            child: Container(
              height: AppSize.s92.h,
              // width: AppSize.s92.w,
              margin: EdgeInsets.only(top: PaddingValues.p15.h),
              child: Image.network(
                productImage,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => Container(
                  child: SvgPicture.asset(IconsConstants.placeholder),
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s10.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: MarginValues.m11.w),
              child: Text(
                productName,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: ColorsConstants.black1,
                      fontSize: FontSize.s14,
                    ),
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            height: AppSize.s4,
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: MarginValues.m11.w),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     // crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Text(
          //           "${isOffer ? productOfferPrice : productPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
          //           style: Theme.of(context)
          //               .textTheme
          //               .titleLarge!
          //               .copyWith(color: ColorsConstants.black1,fontSize: FontSize.s18.sp, letterSpacing: -.90)),
          //       SizedBox(
          //         width: AppSize.s11,
          //       ),
          //       // SizedBox(
          //       //   width: 5.w,
          //       // ),
          //       isOffer
          //           ? Stack(
          //               clipBehavior: Clip.none,
          //               children: [
          //                 Positioned(
          //                   // right: -2,
          //                   // left: 39,
          //                   left: isAr?-5.w:2.w,
          //                   bottom: 11.h,
          //
          //                   child: Transform.rotate(
          //                     angle: 2.8.r,
          //                     child: Container(
          //                       width: 54.41.w,
          //                       decoration: BoxDecoration(
          //                         border: Border.all(
          //                           color: Colors.grey,
          //                           width: 1.w,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Text(
          //                   "${isOffer ? productPrice : productPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .bodySmall!
          //                       .copyWith(color: ColorsConstants.black1,fontWeight: FontWeight.w300, fontSize: FontSize.s12),
          //                 ),
          //               ],
          //             )
          //           : Container()
          //     ],
          //   ),
          // ),

          // Text("SAR 221",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: FontSize.s18)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: MarginValues.m11.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center, // Use CrossAxisAlignment.center to vertically align text
              children: [
                Expanded(
                  child: Text(
                    "${isOffer ? productOfferPrice : productPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorsConstants.black1,
                      fontSize: FontSize.s18.sp,
                      letterSpacing: -0.90,
                    ),
                    overflow: TextOverflow.ellipsis, // Use ellipsis for overflow
                  ),
                ),
                SizedBox(
                  width: AppSize.s11,
                ),
                isOffer
                    ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: isAr ? -5.w : 2.w,
                      bottom: 11.h,
                      child: Transform.rotate(
                        angle: 2.8.r,
                        child: Container(
                          width: 54.41.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${isOffer ? productPrice : productPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorsConstants.black1,
                        fontWeight: FontWeight.w300,
                        fontSize: FontSize.s12,
                      ),
                      overflow: TextOverflow.ellipsis, // Use ellipsis for overflow
                    ),
                  ],
                )
                    : Container()
              ],
            ),
          ),

          SizedBox(
            height: AppSize.s11.h,
          ),

          MainButton(
            onPressed: (){
              addToCart!();
            },
            height: AppSize.s40.h,
            text: StringsConstants.addToCart.tr(),
            color: ColorsConstants.black,
            margin: MarginValues.m10.w,
            radius: AppSize.s5.r,
            textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorsConstants.white, fontSize: FontSize.s14, fontFamily: "Inter"),
          )
        ],
      ),
    );
  }
}
