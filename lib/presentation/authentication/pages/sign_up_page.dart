import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/register_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/register_event.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/register_state.dart';
import 'package:extreme_store/presentation/authentication/widgets/aut_app_bar.dart';
import 'package:extreme_store/presentation/authentication/widgets/auth_bottom_button.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/authentication/widgets/social_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.addListener(() {
      if (!_firstNameFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(FirstNameUnfocused());
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
      }
    });
    _lastNameFocusNode.addListener(() {
      if (!_lastNameFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(LastNameUnfocused());
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_phoneFocusNode);
      }
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(PhoneNumberUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AuthAppBar(title: StringsConstants.createAccount.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingValues.p24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  StringsConstants.letsCreateYourAccount.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 20.r),
                FirstNameWidget(
                  firstNameTextController: _firstNameTextController,
                  firstNameFocusNode: _firstNameFocusNode,
                ),
                SizedBox(height: 20.r),
                LastNameWidget(
                  lastNameTextController: _lastNameTextController,
                  lastNameFocusNode: _lastNameFocusNode,
                ),
                SizedBox(height: 20.r),
                EmailWidget(
                  emailTextController: _emailTextController,
                  emailFocusNode: _emailFocusNode,
                ),
                SizedBox(height: 20.r),
                PhoneNumberWidget(
                  phoneNumberTextController: _phoneNumberTextController,
                  phoneFocusNode: _phoneFocusNode,
                ),
                SizedBox(height: 20.r),
                PasswordWidget(
                  passwordTextController: _passwordTextController,
                  passwordFocusNode: _passwordFocusNode,
                ),
                SizedBox(height: 24.r),
                const SignUpButtonWidget(),
                SizedBox(height: 24.r),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: ColorsConstants.semiLightBlack,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.r),
                      child: Text(
                        StringsConstants.or.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const Expanded(
                        child: Divider(
                      color: ColorsConstants.semiLightBlack,
                    )),
                  ],
                ),
                SizedBox(height: 24.r),
                SocialButton(
                  title: StringsConstants.signUpWithGoogle.tr(),
                  imagePath: IconsConstants.googleIC,
                  onPressed: () {},
                  backGroundColor: ColorsConstants.white,
                  foreGroundColor: ColorsConstants.black,
                  borderColor: ColorsConstants.black,
                ),
                SizedBox(height: 10.r),
                SocialButton(
                  title: StringsConstants.signUpWithApple.tr(),
                  imagePath: IconsConstants.appleIC,
                  onPressed: () {},
                  backGroundColor: ColorsConstants.white,
                  foreGroundColor: ColorsConstants.black,
                  borderColor: ColorsConstants.black,
                ),
                AuthBottomButton(
                  title: StringsConstants.alreadyMember.tr(),
                  pageName: StringsConstants.login.tr(),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status == FormzSubmissionStatus.inProgress
            ? const CustomLoader()
            : ReusableElevatedButton(
                title: StringsConstants.signUp.tr(),
                foreGroundColor: ColorsConstants.white,
                disabledBackGroundColor: ColorsConstants.semiLightBlack,
                onPressed: state.isValid
                    ? () {
                        context.read<RegisterBloc>().add(FormSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
    required TextEditingController passwordTextController,
    required FocusNode passwordFocusNode,
  })  : _passwordTextController = passwordTextController,
        _passwordFocusNode = passwordFocusNode;

  final TextEditingController _passwordTextController;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.password.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.password.displayError != null
                      ? Text(
                          StringsConstants.notValidWord.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorsConstants.red,
                              ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            RoundedTextField(
              textEditingController: _passwordTextController,
              focusNode: _passwordFocusNode,
              isEnabled: true,
              hintText: StringsConstants.enterYourPassword.tr(),
              haveSuffix: true,
              suffixIcon: IconsConstants.eyeOffIC,
              onChanged: (value) {
                context.read<RegisterBloc>().add(PasswordChanged(password: value));
              },
              errorText: state.password.displayError != null ? '' : null,
              filledColor: state.password.displayError != null
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.lighterBlack,
            ),
          ],
        );
      },
    );
  }
}

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({
    super.key,
    required TextEditingController phoneNumberTextController,
    required FocusNode phoneFocusNode,
  })  : _phoneNumberTextController = phoneNumberTextController,
        _phoneFocusNode = phoneFocusNode;

  final TextEditingController _phoneNumberTextController;
  final FocusNode _phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.phoneNumber.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.phoneNumber.displayError != null
                      ? Text(
                    StringsConstants.notValidPhone.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorsConstants.red,
                              ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            RoundedTextField(
              textEditingController: _phoneNumberTextController,
              focusNode: _phoneFocusNode,
              isEnabled: true,
              hintText: StringsConstants.enterYourPhoneNumber.tr(),
              onChanged: (value) {
                context.read<RegisterBloc>().add(PhoneNumberChanged(phoneNumber: value));
              },
              errorText: state.phoneNumber.displayError != null ? '' : null,
              filledColor: state.phoneNumber.displayError != null
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.lighterBlack,
            ),
          ],
        );
      },
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
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                    StringsConstants.notValidEmail.tr(),
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
                context.read<RegisterBloc>().add(EmailChanged(email: value));
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

class LastNameWidget extends StatelessWidget {
  const LastNameWidget({
    super.key,
    required TextEditingController lastNameTextController,
    required FocusNode lastNameFocusNode,
  })  : _lastNameTextController = lastNameTextController,
        _lastNameFocusNode = lastNameFocusNode;

  final TextEditingController _lastNameTextController;
  final FocusNode _lastNameFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.lastName.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.lastName.displayError != null
                      ? Text(
                          StringsConstants.notValid.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorsConstants.red,
                              ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            RoundedTextField(
              textEditingController: _lastNameTextController,
              focusNode: _lastNameFocusNode,
              isEnabled: true,
              hintText: StringsConstants.enterYourLastName.tr(),
              onChanged: (value) {
                context.read<RegisterBloc>().add(LastNameChanged(lastName: value));
              },
              errorText: state.lastName.displayError != null ? '' : null,
              filledColor: state.lastName.displayError != null
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.lighterBlack,
            ),
          ],
        );
      },
    );
  }
}

class FirstNameWidget extends StatelessWidget {
  const FirstNameWidget({
    super.key,
    required TextEditingController firstNameTextController,
    required FocusNode firstNameFocusNode,
  })  : _firstNameTextController = firstNameTextController,
        _firstNameFocusNode = firstNameFocusNode;

  final TextEditingController _firstNameTextController;
  final FocusNode _firstNameFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.firstName.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.firstName.displayError != null
                      ? Text(
                    StringsConstants.notValid.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorsConstants.red,
                              ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            RoundedTextField(
              textEditingController: _firstNameTextController,
              focusNode: _firstNameFocusNode,
              isEnabled: true,
              hintText: StringsConstants.enterYourFirstName.tr(),
              onChanged: (value) {
                context.read<RegisterBloc>().add(FirstNameChanged(firstName: value));
              },
              errorText: state.firstName.displayError != null ? '' : null,
              filledColor: state.firstName.displayError != null
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.lighterBlack,
            ),
          ],
        );
      },
    );
  }
}

// Row(
//   children: [
//     Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 5.r),
//             child: Text(
//               StringsConstants.firstName,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           const RoundedTextField(
//             isEnabled: true,
//             hintText: StringsConstants.enterYourEmailAddress,
//           ),
//         ],
//       ),
//     ),
//     const SizedBox(width: 12),
//     Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 5.r),
//             child: Text(
//               StringsConstants.lastName,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           const RoundedTextField(
//             isEnabled: true,
//             hintText: StringsConstants.enterYourEmailAddress,
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
