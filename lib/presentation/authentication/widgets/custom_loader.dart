import 'package:flutter/material.dart';

import '../../../app/constants/colors_constants.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(
            color: ColorsConstants.black,
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
