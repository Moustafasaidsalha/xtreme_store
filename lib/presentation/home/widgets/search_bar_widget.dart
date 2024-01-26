import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/text_field_with_prefix.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(RoutesConstant.search),
      child:  TextFieldWithPrefix(
        isEnabled: false,
        havePrefix: true,
        prefixIcon: IconsConstants.searchIC,
        hintText: StringsConstants.searchOrProducts.tr(),
      ),
    );
  }
}
