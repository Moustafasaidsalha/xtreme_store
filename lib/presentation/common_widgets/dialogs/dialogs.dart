
import 'package:flutter/material.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void showCustomSnackBar(BuildContext context, String message,{Color? color}) {
  ScaffoldMessenger.of(_scaffoldKey.currentContext ?? context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(

        content: Text(message,style: const TextStyle(color: ColorsConstants.white)),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: color??ColorsConstants.black,
        elevation: 8,
      ),
    );
}
