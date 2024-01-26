import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/presentation/my_account/model_view/account_cubit.dart';

import '../../../domain/repositories/user_preference_repo.dart';

class ChooseCountry extends StatefulWidget {
  final UserPreferenceRepo userPreferenceRepo;

  @override
  State<ChooseCountry> createState() => _ChooseCountryState();

  const ChooseCountry({
    super.key,
    required this.userPreferenceRepo,
  });
}

class _ChooseCountryState extends State<ChooseCountry> {
  @override
  void initState() {
    super.initState();
    country = widget.userPreferenceRepo.getCountry();
  }

  String country = "";
  final List<bool> selected = [true, false, false, true, false, false];

  final List<String> countries = [
    StringsConstants.kuwait,
    StringsConstants.saudi,
    StringsConstants.emarat,
    StringsConstants.qatar,
    StringsConstants.oman,
    StringsConstants.bahrain,
  ];

  final List<String> countriesFlag = [
    IconsConstants.kuwait,
    IconsConstants.saudi,
    IconsConstants.emarat,
    IconsConstants.qatar,
    IconsConstants.oman,
    IconsConstants.bahrain,
  ];

  final List<String> icons = [IconsConstants.checkIC, IconsConstants.circleBorderIC];

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 390.w,
          // height: 312.h,
          // clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 22.h),
          margin: EdgeInsets.symmetric(horizontal: 19.w),
          decoration: const BoxDecoration(color: ColorsConstants.white),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    StringsConstants.selectCountry.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(IconsConstants.closeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      AccountCubit.get(context).changeCountry(CountryUtility.countriesDataList[index].id,context);
// setState(() {
//   widget.userPreferenceRepo.insertSelectedCountryID(value: CountryUtility.countriesDataList[index].id);
//
// });
// setState(() {
//   Navigator.pop(context);
// });
                    },
                    child: Row(children: [
                Container(
                    // child: SvgPicture.asset(countries[index]==country?icons[0]:icons[1],height: 24.h,width: 24.w,),
                    child: SvgPicture.asset(widget.userPreferenceRepo.getSelectedCountryID()==CountryUtility.countriesDataList[index].id?icons[0]:icons[1],height: 24.h,width: 24.w,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                ),
SizedBox(width: 18.w,),
                Text(isAr?CountryUtility.countriesDataList[index].nameAR:CountryUtility.countriesDataList[index].nameEN,style: Theme.of(context).textTheme.bodySmall,),
               const Spacer(),
                Container(
                      width: 38.w,
                      height: 26.h,                  child: SvgPicture.asset(CountryUtility.countriesDataList[index].iconPath))
              ],),
                  ), separatorBuilder: (context, index) => SizedBox(height: 56.h,), itemCount:CountryUtility.countriesDataList.length)
            ],
          ),
        ),
      ),
    );
  }
}
