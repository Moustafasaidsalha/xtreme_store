import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';


class ThemeManager {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme:  AppBarTheme(
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: ColorsConstants.black,
          // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,

          fontSize: FontSize.s32.sp,
          fontWeight: FontWeight.w700,
          // height: .49,
          letterSpacing: -1.60,
        ),
        scrolledUnderElevation: 0,
        backgroundColor: ColorsConstants.backGround,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsConstants.iconsColor)
      ),
      scaffoldBackgroundColor: ColorsConstants.backGround,
      iconTheme: IconThemeData(color: ColorsConstants.iconsColor),
      useMaterial3: true,
      textTheme: lightTextTheme,
      // primaryColor:sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():const Color(0xFF000000),
      primaryColor:Colors.teal,


    );
  }

  static TextTheme get lightTextTheme {
    ///TODO need to refactor
    return TextTheme(
      // displayLarge: getBoldStyle(fontSize: FontSize.s30, color: ColorsConstants.black),
      // displayMedium: getMediumStyle(fontSize: FontSize.s16, color: ColorsConstants.black),
      // displaySmall: getLightStyle(fontSize: FontSize.s12, color: ColorsConstants.black),

      displayMedium: TextStyle(
        color: ColorsConstants.black,
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,

        fontSize: FontSize.s16.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.90,
      ),
      displaySmall: TextStyle(
        color: ColorsConstants.gray,
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.gray,
        fontSize: FontSize.s14.sp,
        fontWeight: FontWeight.w400,
      ),

      ///
      titleLarge:  TextStyle(
        color: ColorsConstants.black,
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,
        fontSize: FontSize.s32.sp,
        fontWeight: FontWeight.w700,
        // height: 4.9,
        letterSpacing: -1.60,
      ),
      titleMedium:  TextStyle(
        color: ColorsConstants.black,
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.32,
      ),
      titleSmall:  TextStyle(
        color: ColorsConstants.black,
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),

      ///
      bodySmall:  TextStyle(
        color: ColorsConstants.lightBlack,

        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.lightBlack,
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
      ),

      ///
      headlineMedium:  TextStyle(
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,

        color: ColorsConstants.black,
        fontSize: FontSize.s16.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall:  TextStyle(
        color: ColorsConstants.gray,
        fontSize: FontSize.s12.sp,
        fontWeight: FontWeight.w500,
        height: 1.7,
      ),
    );

    ///
    // titleLarge: getBoldStyle(fontSize: FontSize.s32, color: ColorsConstants.black),
    // titleMedium: getMediumStyle(fontSize: FontSize.s16, color: ColorsConstants.black),
    // titleSmall: getRegularStyle(fontSize: FontSize.s14, color: ColorsConstants.black),
    //
    // ///
    // bodySmall:getRegularStyle(fontSize: FontSize.s12, color: ColorsConstants.black),
    //
    // ///
    // headlineMedium: getBoldStyle(fontSize: FontSize.s16, color: ColorsConstants.black));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: darkTextTheme,
    );
  }

  static TextTheme get darkTextTheme {
    return const TextTheme(
        // displayLarge: getBoldStyle(fontSize: FontSize.s30, color: ColorsConstants.white),
        // displayMedium: getMediumStyle(fontSize: FontSize.s16, color: ColorsConstants.white),
        // displaySmall: getLightStyle(fontSize: FontSize.s12, color: ColorsConstants.white),

        // ///
        // titleLarge: getBoldStyle(fontSize: FontSize.s32, color: ColorsConstants.white),
        // titleMedium: getMediumStyle(fontSize: FontSize.s16, color: ColorsConstants.white),
        // titleSmall: getRegularStyle(fontSize: FontSize.s14, color: ColorsConstants.white),
        //
        // ///
        // bodySmall: getRegularStyle(fontSize: FontSize.s12, color: ColorsConstants.white),
        //
        // ///
        // headlineMedium: getBoldStyle(fontSize: FontSize.s16, color: ColorsConstants.white)
        );
  }
}
