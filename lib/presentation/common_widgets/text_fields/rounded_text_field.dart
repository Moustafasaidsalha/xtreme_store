import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/theme/decoration_manager.dart';

class RoundedTextField extends StatelessWidget {
  final bool isEnabled;
  final String? hintText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final void Function()? onTextClear;
  final bool haveSuffix;
  final String suffixIcon;
  final void Function(String)? onChanged;
  final String? errorText;
  final Color filledColor;
  final Widget? prefixWidget;


  const RoundedTextField({
    Key? key,
    required this.isEnabled,
    this.textEditingController,
    this.focusNode,
    this.onSubmitted,
    this.hintText,
    this.onTextClear,
    this.haveSuffix = false,
    this.suffixIcon = '',
    this.onChanged,
    this.errorText,
    this.filledColor = ColorsConstants.lighterBlack,
    this.prefixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      onChanged: onChanged,
      enabled: isEnabled, onSubmitted: onSubmitted,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      // style: TextStyle(
      //     decoration: TextDecoration.none,
      //     fontFamily: Fonts.ibm,
      //     fontWeight: FontsWeight.regular,
      //     fontSize: 14.0.toValue(context),
      //     color: Theme.of(context).black,
      //     height: 2),
      // onSubmitted: onSubmitted,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 0), errorText: errorText,
        border: DecorationManager.textFieldBorder,
        enabledBorder: DecorationManager.textFieldBorder,
        focusedBorder: DecorationManager.textFieldBorder,
        disabledBorder: DecorationManager.textFieldBorder,
        filled: true,
        fillColor: filledColor,
        contentPadding: EdgeInsets.all(16.r),
        hintText: hintText ?? '',
        hintStyle: Theme.of(context).textTheme.bodySmall,
        // suffixIcon: haveSuffix ? SvgPicture.asset(suffixIcon) : const SizedBox(),
        suffixIcon: haveSuffix
            ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: SvgPicture.asset(suffixIcon,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn),),
            )
            : const SizedBox(),
        prefixIcon: prefixWidget,
      ),
    );
  }
}


class RoundedTextFieldWithSuffixWidget extends StatelessWidget {
  final bool isEnabled;
  final String? hintText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final void Function()? onTextClear;
  final void Function(String)? onChanged;
  final String? errorText;
  final Color filledColor;
  final Widget? prefixWidget;
  final Widget? suffixWidget;


  const RoundedTextFieldWithSuffixWidget({
    Key? key,
    required this.isEnabled,
    this.textEditingController,
    this.focusNode,
    this.onSubmitted,
    this.hintText,
    this.onTextClear,
    this.onChanged,
    this.errorText,
    this.filledColor = ColorsConstants.lighterBlack,
    this.prefixWidget,
    this.suffixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      onChanged: onChanged,
      enabled: isEnabled, onSubmitted: onSubmitted,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 0), errorText: errorText,
        border: DecorationManager.textFieldBorder,
        enabledBorder: DecorationManager.textFieldBorder,
        focusedBorder: DecorationManager.textFieldBorder,
        disabledBorder: DecorationManager.textFieldBorder,
        filled: true,
        fillColor: filledColor,
        contentPadding: EdgeInsets.all(16.r),
        hintText: hintText ?? '',
        hintStyle: Theme.of(context).textTheme.bodySmall,
        suffix: suffixWidget,
        prefixIcon: prefixWidget,
      ),
    );
  }
}
