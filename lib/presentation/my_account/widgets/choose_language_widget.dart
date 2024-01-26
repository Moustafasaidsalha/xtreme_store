import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/my_account/model_view/account_cubit.dart';

class ChooseLanguageWidget extends StatelessWidget {
   ChooseLanguageWidget({super.key});
  final List<String> languages=["English","العربيه"];
   final List<String> icons=[IconsConstants.checkIC,IconsConstants.circleBorderIC];
   // final Map<bool,String> icons={
   //   false:IconsConstants.checkIC,false:IconsConstants.circleBorderIC};



   @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: 390.w,
        height: 219.h,
        // clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.only(left:19.w,right:19.w,top: 19.h ),
        margin: EdgeInsets.symmetric(horizontal: 19.w),
        decoration: const BoxDecoration(color: ColorsConstants.white),child:
      Column(
        children: [
          Row(children: [
            Text(StringsConstants.selectLanguage.tr(),style: Theme.of(context).textTheme.titleMedium,),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(IconsConstants.closeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
            )
          ],),
          SizedBox(height: 44.h,),

          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  AccountCubit.get(context).changeLanguage(index, context);

                },
                child: Row(children: [
                  Container(
                    // padding:  EdgeInsets.symmetric(horizontal:icons[index]==IconsConstants.circleBorderIC?3.w:0 ),

                    child: SvgPicture.asset(index==0?context.locale == const Locale("en", "US")?icons[0]:icons[1]:context.locale == const Locale("ar", "EG")?icons[0]:icons[1],height: 24.h,width: 24.w,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                  ),
                  SizedBox(width: 18.w,),
                  Text(languages[index],style: Theme.of(context).textTheme.bodySmall,),
                ],),
              ), separatorBuilder: (context, index) => SizedBox(height: 56.h,), itemCount: 2)
        ],
      ),    ),
    );
  }
}
