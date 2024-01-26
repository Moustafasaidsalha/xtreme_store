import 'package:flutter/material.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/theme/decoration_manager.dart';

class CouponTextField extends StatelessWidget {
  final bool isEnabled;
  final String? hintText;
  final TextEditingController? textEditingController;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChange;

  final Color fillColor;
  final Widget suffixWidget;

  const CouponTextField({
    Key? key,
    required this.isEnabled,
    this.textEditingController,
    this.onSubmitted,
    this.hintText,
    this.fillColor = ColorsConstants.lightBlack,
    required this.suffixWidget,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChange,
      controller: textEditingController,
      enabled: isEnabled, onFieldSubmitted: onSubmitted,
      // style: TextStyle(
      //     decoration: TextDecoration.none,
      //     fontFamily: Fonts.ibm,
      //     fontWeight: FontsWeight.regular,
      //     fontSize: 14.0.toValue(context),
      //     color: Theme.of(context).black,
      //     height: 2),
      // onSubmitted: onSubmitted,
      decoration: InputDecoration(
        border: DecorationManager.textFieldBorder,
        enabledBorder: DecorationManager.textFieldBorder,
        focusedBorder: DecorationManager.textFieldBorder,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText ?? '',
        hintStyle: Theme.of(context).textTheme.bodySmall,
        // suffix: Text(StringsConstants.apply,style: Theme.of(context).textTheme.bodyMedium),
        suffixIcon: suffixWidget,
      ),
    );
  }
}
