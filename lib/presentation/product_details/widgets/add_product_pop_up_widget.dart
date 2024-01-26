import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/layout/model_view/layout_cubit.dart';

class AddProductPopUpWidget extends StatelessWidget {
  const AddProductPopUpWidget({super.key,required this.productName,required this.cartTotalPrice});
final String productName;
  final double cartTotalPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
padding: EdgeInsets.symmetric(horizontal: 19.w,vertical: 20.h),
          color: Colors.white,
          height: 300.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                productName,
                style:Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: FontSize.s14,height: 2.14,
                  letterSpacing: 0.14,overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                SvgPicture.asset(IconsConstants.checkIC,colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),height: 24.h,width: 24.w,),
SizedBox(width: 15.w,),
                Text(
                StringsConstants.addedToCart.tr(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorsConstants.green),
              ),],),
              SizedBox(height: 17.h,),

Row(children: [
  Text(
        'Cart total',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorsConstants.gray),
  ),
  Spacer(),
  Text(
        '$cartTotalPrice ${CountryUtility.countriesDataList.firstWhere((element) => element.id==sl<UserPreferenceRepo>().getSelectedCountryID()).currency}',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorsConstants.black),
  )
],)  ,
              SizedBox(height: 16.h,),


              ReusableElevatedButton(title: StringsConstants.viewCart.tr(), onPressed: () {
                LayoutCubit.get(context).bottomNavIndex=2;
                Navigator.of(context).pushNamedAndRemoveUntil(RoutesConstant.cartFromDetails,(route) => false,);



              },),
              SizedBox(height: 16.h,),

              ReusableElevatedButton(
                backGroundColor: Colors.white,
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),

                title: StringsConstants.continueShopping.tr(), onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(RoutesConstant.homeLanding,(route) => false,);

              },),

            ],
          ),
        ),
      ),
    );
  }
}
