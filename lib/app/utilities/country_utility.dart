import 'package:extreme_store/app/constants/strings_constants.dart';

import '../constants/icon_constants.dart';

class CountryUtility {
  static const Map<String, CountryDataModel> countriesData = {
    StringsConstants.kuwait: CountryDataModel(
      id: 1,
      nameAR: 'الكويت',
      nameEN: 'Kuwait',
      currency: 'KWD',
      code: '+965',
      iconPath: IconsConstants.kuwait,
    ),
    StringsConstants.emarat: CountryDataModel(
      id: 2,
      nameAR: 'الإمارات العربية المتحدة',
      nameEN: 'UAE',
      currency: 'AED',
      code: '+971',
      iconPath: IconsConstants.emarat,
    ),
    StringsConstants.saudi: CountryDataModel(
      id: 3,
      nameAR: 'السعودية',
      nameEN: 'KSA',
      currency: 'SAR',
      code: '+966',
      iconPath: IconsConstants.saudi,
    ),
    StringsConstants.qatar: CountryDataModel(
      id: 4,
      nameAR: 'قطر',
      nameEN: 'Qatar',
      currency: 'QAR',
      code: '+974',
      iconPath: IconsConstants.qatar,
    ),
    StringsConstants.bahrain: CountryDataModel(
      id: 5,
      nameAR: 'البحرين',
      nameEN: 'Bahrain',
      currency: 'BHD',
      code: '+973',
      iconPath: IconsConstants.bahrain,
    ),
    StringsConstants.oman: CountryDataModel(
      id: 6,
      nameAR: 'سلطنة عمان',
      nameEN: 'Oman',
      currency: 'OMR',
      code: '+968',
      iconPath: IconsConstants.oman,
    ),
  };
  static const List<CountryDataModel> countriesDataList = [
    CountryDataModel(
      id: 1,
      nameAR: 'الكويت',
      nameEN: 'Kuwait',
      currency: 'KWD',
      code: '+965',
      iconPath: IconsConstants.kuwait,
    ),
    CountryDataModel(
      id: 2,
      nameAR: 'الإمارات العربية المتحدة',
      nameEN: 'UAE',
      currency: 'AED',
      code: '+971',
      iconPath: IconsConstants.emarat,
    ),
    CountryDataModel(
      id: 3,
      nameAR: 'السعودية',
      nameEN: 'KSA',
      currency: 'SAR',
      code: '+966',
      iconPath: IconsConstants.saudi,
    ),
    CountryDataModel(
      id: 4,
      nameAR: 'قطر',
      nameEN: 'Qatar',
      currency: 'QAR',
      code: '+974',
      iconPath: IconsConstants.qatar,
    ),
    CountryDataModel(
      id: 5,
      nameAR: 'البحرين',
      nameEN: 'Bahrain',
      currency: 'BHD',
      code: '+973',
      iconPath: IconsConstants.bahrain,
    ),
    CountryDataModel(
      id: 6,
      nameAR: 'سلطنة عمان',
      nameEN: 'Oman',
      currency: 'OMR',
      code: '+968',
      iconPath: IconsConstants.oman,
    ),
  ];

  static bool isBaseCountry({required String currency}) {
    return currency == 'KWD' ? true : false;
  }
}

class CountryDataModel {
  final int id;
  final String nameAR;
  final String nameEN;
  final String code;
  final String iconPath;
  final String currency;

  const CountryDataModel({
    required this.id,
    required this.nameAR,
    required this.nameEN,
    required this.code,
    required this.iconPath,
    required this.currency,
  });
}

// export const country = [
//   {
//     id: 1,
//     name_en: "Kuwait",
//     name_ar: "الكويت",
//     type: "KWD",
//   },
//   {
//     id: 2,
//     name_en: "UAE",
//     name_ar: "الإمارات العربية المتحدة",
//     type: "AED",
//   },
//   {
//     id: 3,
//     name_en: "KSA",
//     name_ar: "السعودية",
//     type: "SAR",
//   },
//   {
//     id: 4,
//     name_en: "Qatar",
//     name_ar: "قطر",
//     type: "QAR",
//   },
//   {
//     id: 5,
//     name_en: "Bahrain",
//     name_ar: "البحرين",
//     type: "BHD",
//   },
//   {
//     id: 6,
//     name_en: "Oman",
//     name_ar: "سلطنة عمان",
//     type: "OMR",
//   },
// ];
