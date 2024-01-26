import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';

import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/empty_states/empty_states.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
final bool isEmpty=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWithActionButton(title: StringsConstants.notifications.tr()),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 21.h),
          child: Column(
            children: [
              isEmpty?Column(
                children: [
                  SizedBox(height: 70.h,),
                  EmptyStatesWidget(icon: IconsConstants.noNotificationIC, title: StringsConstants.noNotificationsYetTitle.tr(), subTitle:  StringsConstants.noNotificationsYetSubTitle.tr(), buttonTitle:  StringsConstants.refresh.tr(), buttonHeight: AppSize.s55, buttonColor: ColorsConstants.black, buttonMargin: MarginValues.m0, buttonRadius: AppSize.s10, buttonTextColor: ColorsConstants.white, spaceBetweenSubtitleAndButton: AppSize.s152, onPressed: () {

                  },),
                ],
              )  : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) =>
                  Container(
                    color: ColorsConstants.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(IconsConstants.holeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                            SizedBox(width: 6.w,),
                             Text("""Lorem ipsum dolor sit amet""",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: FontSize.s12),),
                            SizedBox(width: 6.w,),

                            SvgPicture.asset(IconsConstants.pointIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),

                            SizedBox(width: 6.w,),
                             Text("""now""",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12),),
                            SizedBox(width: 6.w,),

                            Transform.flip(
                              flipY: false,
                                child: SvgPicture.asset(IconsConstants.arrowUpSmallIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn))),



                          ],
                        ),
                        SizedBox(height: 9.h,),
                         Text("""Hi Anastassia!""",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s15,color: ColorsConstants.black3)),
                        SizedBox(height: 4.h,),

                         Text(
                            """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip""",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s13,height: 2)),

                        SizedBox(height: 16.h,),
                        // Image.asset(ImagesConstants.background)
                      ],
                    ),
                  ), separatorBuilder: (context, index) =>SizedBox(height: 16.h,), itemCount: 10)
            ],
          ),
        ),
      ),
    );
  }
}
