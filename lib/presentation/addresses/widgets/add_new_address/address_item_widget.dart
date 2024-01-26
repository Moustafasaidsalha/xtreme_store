import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/constants/strings_constants.dart';
import '../../../common_widgets/text_fields/rounded_text_field.dart';

class AddAddressItemWidget extends StatelessWidget {
  const AddAddressItemWidget({
    super.key,
    required this.title,
    required this.textEditingController,
    this.isOptional = false,
    this.onChanged,
  });
  final String title;
  final bool isOptional;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Text(
            '$title ${isOptional ? StringsConstants.optional.tr() : '*'}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        RoundedTextField(
          textEditingController: textEditingController,
          isEnabled: true,
          hintText: StringsConstants.enterHere.tr(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
