import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/constants/colors_constants.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    super.key,
    required this.isSelected,
    this.backgroundColor,
  });

  final bool isSelected;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.r,
      width: 25.r,
      decoration: BoxDecoration(
        color: isSelected ? backgroundColor ?? ColorsConstants.black : ColorsConstants.backGround,
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorsConstants.gray,
          width: 0.5.r,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: isSelected
          ? Icon(Icons.done, size: 18.r, color: ColorsConstants.white)
          : const SizedBox(),
    );
  }
}
