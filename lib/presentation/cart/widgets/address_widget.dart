import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';

import '../../addresses/widgets/address_selection_widget.dart';

class AddressWidget extends StatelessWidget implements PreferredSizeWidget {
  const AddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: AddressSelectionWidget(
        backgroundColor: ColorsConstants.lightGray.withOpacity(0.2),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0.r);
}

