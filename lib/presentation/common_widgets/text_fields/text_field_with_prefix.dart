import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/theme/decoration_manager.dart';

class TextFieldWithPrefix extends StatelessWidget {
  final bool isEnabled;
  final String? hintText;
  final TextEditingController? textEditingController;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final bool havePrefix;
  final String prefixIcon;

  const TextFieldWithPrefix({
    Key? key,
    required this.isEnabled,
    this.textEditingController,
    this.onSubmitted,
    this.onChanged,
    this.hintText,
    this.havePrefix = false,
    this.prefixIcon = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: isEnabled,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: ColorsConstants.lightBlack,
          ),
      decoration: InputDecoration(
        border: DecorationManager.textFieldWithNoBorder,
        enabledBorder: DecorationManager.textFieldWithNoBorder,
        focusedBorder: DecorationManager.textFieldWithNoBorder,
        disabledBorder: DecorationManager.textFieldWithNoBorder,
        filled: true,
        fillColor: ColorsConstants.lightGray.withOpacity(0.2),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText ?? '',
        hintStyle: Theme.of(context).textTheme.displaySmall,
        prefixIcon: havePrefix
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: SvgPicture.asset(prefixIcon,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
              )
            : const SizedBox(),
      ),
    );
  }
}
