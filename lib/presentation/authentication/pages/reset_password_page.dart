import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/reset_password_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/reset_password_state.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/events/reset_password_event.dart';
import '../widgets/custom_loader.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailTextController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<ResetPasswordBloc>().add(ResetPasswordEmailUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          showCustomSnackBar(context, state.errorMessage);
        } else if (state.status == FormzSubmissionStatus.success) {
          Navigator.of(context).pop();
          showCustomSnackBar(context, state.errorMessage);

          // Navigator.of(context).pushNamed(
          //   RoutesConstant.verifyResetPasswordCode,
          //   arguments: VerifyResetPasswordCodeArgs(
          //     email: _emailTextController.text,
          //   ),
          // );
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
                  StringsConstants.resetYourPassword.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 15.r),
                Text(
                  StringsConstants.doNotWorryItHappens.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(flex: 1, child: SizedBox()),
                EmailWidget(
                  emailTextController: _emailTextController,
                  emailFocusNode: _emailFocusNode,
                ),
                SizedBox(height: 30.r),
                const ContinueButtonWidget(),
                const Expanded(flex: 4, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required TextEditingController emailTextController,
    required FocusNode emailFocusNode,
  })  : _emailTextController = emailTextController,
        _emailFocusNode = emailFocusNode;

  final TextEditingController _emailTextController;
  final FocusNode _emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.email.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.email.displayError != null
                      ? Text(
                          StringsConstants.writeValidEmail.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorsConstants.red,
                              ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            RoundedTextField(
              textEditingController: _emailTextController,
              focusNode: _emailFocusNode,
              isEnabled: true,
              hintText: StringsConstants.enterYourEmailAddress.tr(),
              onChanged: (value) {
                context.read<ResetPasswordBloc>().add(RestPasswordEmailChanged(email: value));
              },
              errorText: state.email.displayError != null ? '' : null,
              filledColor: state.email.displayError != null
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.lighterBlack,
            ),
          ],
        );
      },
    );
  }
}

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const CustomLoader();
        } else {
          return ReusableElevatedButton(
            disabledBackGroundColor: ColorsConstants.semiLightBlack,
            title: StringsConstants.continueWord.tr(),
            foreGroundColor: ColorsConstants.white,
            onPressed: state.isValid
                ? () {
                    context.read<ResetPasswordBloc>().add(
                          ResetPasswordFormSubmitted(),
                        );
                  }
                : null,
          );
        }
      },
    );
  }
}
