import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/reset_password_check_code_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/reset_password_check_code_state.dart';
import 'package:extreme_store/presentation/authentication/pages/add_new_password_page.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/events/reset_password_check_code_event.dart';
import '../widgets/custom_loader.dart';

class VerifyResetPasswordCodeArgs {
  final String email;

  VerifyResetPasswordCodeArgs({
    required this.email,
  });
}

class VerifyCodePage extends StatefulWidget {
  final String email;
  const VerifyCodePage({
    super.key,
    required this.email,
  });

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _codeTextController = TextEditingController();
  final _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _codeFocusNode.addListener(() {
      if (!_codeFocusNode.hasFocus) {
        context.read<ResetPasswordCheckCodeBloc>().add(CodeUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _codeTextController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCheckCodeBloc, ResetPasswordCheckCodeState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          showCustomSnackBar(context, state.errorMessage);
        } else if (state.status == FormzSubmissionStatus.success) {
          Navigator.of(context).pushNamed(RoutesConstant.addNewPassword,
              arguments: AddNewPasswordArgs(
                email: widget.email,
                code: _codeTextController.text,
              ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: PaddingValues.p14.r,
              horizontal: PaddingValues.p24.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50.r),
                Text(
                  StringsConstants.checkYourMessage.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 15.r),
                Text(
                  StringsConstants.weSentOTP.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(flex: 2, child: SizedBox()),
                RoundedTextField(
                  isEnabled: true,
                  hintText: StringsConstants.enterOTP.tr(),
                  textEditingController: _codeTextController,
                  focusNode: _codeFocusNode,
                  onChanged: (value) {
                    context.read<ResetPasswordCheckCodeBloc>().add(CodeChanged(code: value));
                  },
                ),
                SizedBox(height: 30.r),
                VerifyButtonWidget(email: widget.email),
                SizedBox(height: 30.r),
                const Expanded(flex: 1, child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '00:34',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 10.r),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringsConstants.didNotGetCode.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            " ${StringsConstants.resend.tr()}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Expanded(flex: 3, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyButtonWidget extends StatelessWidget {
  const VerifyButtonWidget({
    super.key,
    required this.email,
  });

  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCheckCodeBloc, ResetPasswordCheckCodeState>(
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const CustomLoader();
        } else {
          return ReusableElevatedButton(
            disabledBackGroundColor: ColorsConstants.semiLightBlack,
            title: StringsConstants.verify.tr(),
            foreGroundColor: ColorsConstants.white,
            onPressed: state.isValid
                ? () {
                    context.read<ResetPasswordCheckCodeBloc>().add(CheckCodeFormSubmitted(email: email));
                  }
                : null,
          );
        }
      },
    );
  }
}
