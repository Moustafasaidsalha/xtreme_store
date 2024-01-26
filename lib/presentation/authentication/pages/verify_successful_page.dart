import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/images_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:lottie/lottie.dart';

class VerifySuccessfulArgs {
  final String message;
  final VoidCallback onTapDone;

  VerifySuccessfulArgs({required this.message, required this.onTapDone});
}

class VerifySuccessfulPage extends StatelessWidget {
  final String message;
  final VoidCallback onTapDone;
  const VerifySuccessfulPage({
    super.key,
    required this.message,
    required this.onTapDone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.backGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: PaddingValues.p14.r,
            horizontal: PaddingValues.p24.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.r),
              Text(
                StringsConstants.successful.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 20.r),
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Expanded(child: SizedBox()),
              Expanded(flex: 3, child: Lottie.asset(ImagesConstants.success, repeat: false)),
              const Expanded(child: SizedBox()),
              ReusableElevatedButton(
                title: StringsConstants.done.tr(),
                onPressed: onTapDone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
