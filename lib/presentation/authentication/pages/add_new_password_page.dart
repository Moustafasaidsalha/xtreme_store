import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/add_new_password_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/add_new_password_event.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/add_new_password_state.dart';
import 'package:extreme_store/presentation/authentication/pages/verify_successful_page.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

import '../../../app/routes/routes_constants.dart';
import '../../common_widgets/dialogs/dialogs.dart';

class AddNewPasswordArgs {
  final String email;
  final String code;

  AddNewPasswordArgs({
    required this.email,
    required this.code,
  });
}

class AddNewPasswordPage extends StatefulWidget {
  const AddNewPasswordPage({
    super.key,
  });

  @override
  State<AddNewPasswordPage> createState() => _AddNewPasswordPageState();
}

class _AddNewPasswordPageState extends State<AddNewPasswordPage> {
  final _passwordTextController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<AddNewPasswordBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewPasswordBloc, AddNewPasswordState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          showCustomSnackBar(context, state.errorMessage);
        } else if (state.status == FormzSubmissionStatus.success) {
          Navigator.of(context).pushNamed(
            RoutesConstant.verifySuccessful,
            arguments: VerifySuccessfulArgs(
              message: StringsConstants.successfulChangedPassword.tr(),
              onTapDone: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesConstant.loginWithPin,
                  (route) => false,
                );
              },
            ),
          );
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
                  StringsConstants.resetPasswordTips.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.r),
                  child: Text(
                    StringsConstants.password.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                RoundedTextField(
                  isEnabled: true,
                  hintText: StringsConstants.enterYourPassword.tr(),
                  textEditingController: _passwordTextController,
                  focusNode: _passwordFocusNode,
                  onChanged: (value) {
                    context.read<AddNewPasswordBloc>().add(PasswordChanged(password: value));
                  },
                ),
                SizedBox(height: 30.r),
                const ResetButtonWidget(),
                const Expanded(flex: 4, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetButtonWidget extends StatelessWidget {
  const ResetButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewPasswordBloc, AddNewPasswordState>(
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const CustomLoader();
        } else {
          return ReusableElevatedButton(
            disabledBackGroundColor: ColorsConstants.semiLightBlack,
            title: StringsConstants.resetPassword.tr(),
            foreGroundColor: ColorsConstants.white,
            onPressed: state.isValid
                ? () {
                    context.read<AddNewPasswordBloc>().add(AddPasswordFormSubmitted());
                  }
                : null,
          );
        }
      },
    );
  }
}
