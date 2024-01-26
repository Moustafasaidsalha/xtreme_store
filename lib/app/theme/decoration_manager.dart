import 'package:flutter/material.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';

class DecorationManager {
  static OutlineInputBorder textFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide(
      color: ColorsConstants.lighterBlack,
      width: 0.5,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
  );
  static OutlineInputBorder textFieldWithNoBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(5),
    ),
    borderSide: BorderSide(
      color: ColorsConstants.lightGray.withOpacity(0.2),
      width: 0.5,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
  );
}
