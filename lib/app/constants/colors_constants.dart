import 'package:flutter/material.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/utilities/extension.dart';

import '../../domain/repositories/user_preference_repo.dart';

class ColorsConstants {
  static const Color backGround = Color(0xFFFBFBFB);
  static const Color white = Color(0xFFFFFFFF);
  // static const Color black =  black1;
  static Color black1 = const Color(0xFF000000);
  // static const Color  black1 = const Color(0xFF000000);
  // static const Color black = Color(0xff18748f);
  // static const Color black = _black ;
  static final Color iconsColor =
      sl<UserPreferenceRepo>().getMainColor().isNotEmpty
          ? sl<UserPreferenceRepo>().getMainColor().toColor()
          : Colors.grey;
  static final Color black = sl<UserPreferenceRepo>().getMainColor().isNotEmpty
      ? sl<UserPreferenceRepo>().getMainColor().toColor()
      : const Color(0xFF000000);
  // static   Color black = Color(sl<UserPreferenceRepo>().getMainColor().toColor());
  static const Color lightBlack = Color.fromRGBO(0, 0, 0, 0.6);
  static const Color semiLightBlack = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color lighterBlack = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color green = Color(0xFF219653);
  static const Color gray = Color(0xFF8E9AA0);
  static const Color lightGray = Color(0xFFD9D9D9);
  static const Color lightBlue = Color(0x33D9D9D9);
  static const Color red = Color(0xFFEB5757);
  static const Color semiBlack = Color(0xCC000000);
  static const Color lightGrey = Color(0xFFAAAAAA);
  static const Color darkGray = Color(0xFF9E9E9E);
  static const Color darkerGray = Color(0xFF8A8A8A);
  static const Color lighterGray = Color(0xFFF8F8F8);
  static const Color gray1 = Color(0xFFBDBDBD);
  static const Color gray2 = Color(0xFFE0E0E0);
  static const Color black3 = Color(0xFF222222);
  static const Color gray4 = Color(0x33D9D9D9);
  static const Color shadow = Color(0x0F000000);
  static const Color blue = Color(0xFF307EF4);
}
