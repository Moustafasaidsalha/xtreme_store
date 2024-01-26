
import 'package:flutter/material.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';

///TODO
TextStyle _getTextStyle(double fontSize,FontWeight fontWeight,Color color){

  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstant.fontFamily,
    color: color,
  );
}

//regular style
TextStyle getRegularStyle({required double fontSize,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}
//light style

TextStyle getLightStyle({required double fontSize,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}
//medium style
TextStyle getMediumStyle({required double fontSize,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
//semiBold style
TextStyle getSemiBoldStyle({required double fontSize,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
//bold style
TextStyle getBoldStyle({required double fontSize,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}