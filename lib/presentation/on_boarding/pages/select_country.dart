import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';

import '../../../app/constants/icon_constants.dart';
import '../../../app/utilities/country_utility.dart';
import '../widgets/country_item.dart';

class SelectCountry extends StatefulWidget {
  final UserPreferenceRepo userPreferenceRepo;
  const SelectCountry({super.key, required this.userPreferenceRepo});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  int userSelectedCountryId = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    userSelectedCountryId = widget.userPreferenceRepo.getSelectedCountryID();
    selectedIndex = CountryUtility.countriesDataList.indexWhere(
      (element) => element.id == userSelectedCountryId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringsConstants.selectCountry,
        ),
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: PaddingValues.p24.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: CountryUtility.countriesDataList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        userSelectedCountryId = CountryUtility.countriesDataList
                            .firstWhere(
                              (element) => element.id == userSelectedCountryId,
                              orElse: () =>  const   CountryDataModel(
                                id: 1,
                                nameAR: 'الكويت',
                                nameEN: 'Kuwait',
                                currency: 'KWD',
                                code: '+965',
                                iconPath: IconsConstants.kuwait,
                              ),
                            )
                            .id;
                        setState(() {});
                        widget.userPreferenceRepo.insertSelectedCountryID(
                          value: userSelectedCountryId,
                        );
                      },
                      child: CountryItem(
                        isSelected: index == selectedIndex ? true : false,
                        countryFlagPath: CountryUtility.countriesDataList[index].iconPath,
                        countryName: CountryUtility.countriesDataList[index].nameAR,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: ColorsConstants.gray.withOpacity(0.15),
                    );
                  },
                ),
              ),
              ReusableElevatedButton(
                title: StringsConstants.confirm,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RoutesConstant.loginWithPin,
                  );
                },
              ),
              SizedBox(height: 28.r),
            ],
          ),
        ),
      ),
    );
  }
}
