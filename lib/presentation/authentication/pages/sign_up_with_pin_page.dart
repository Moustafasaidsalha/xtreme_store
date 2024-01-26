import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/authentication/widgets/auth_bottom_button.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/pin_widget.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

import '../../../app/routes/routes_constants.dart';
import '../../../app/utilities/country_utility.dart';
import '../../addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import '../../common_widgets/country_widgets/code_selection.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/bloc/sign_up_with_pin_bloc.dart';
import '../model_view/events/sign_up_with_pin_events.dart';
import '../model_view/states/sign_up_with_pin_state.dart';
import '../widgets/phone_prefix_widget.dart';

class SignUpWithPinPage extends StatefulWidget {
  const SignUpWithPinPage({super.key});

  @override
  State<SignUpWithPinPage> createState() => _SignUpWithPinPageState();
}

class _SignUpWithPinPageState extends State<SignUpWithPinPage> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _pinCodeTextController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _pinCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.addListener(() {
      if (!_firstNameFocusNode.hasFocus) {
        context.read<SignUpWithPinBloc>().add(FirstNameUnfocused());
        // FocusScope.of(context).requestFocus(_lastNameFocusNode);
      }
    });
    _lastNameFocusNode.addListener(() {
      if (!_lastNameFocusNode.hasFocus) {
        context.read<SignUpWithPinBloc>().add(LastNameUnfocused());
        // FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignUpWithPinBloc>().add(EmailUnfocused());
        // FocusScope.of(context).requestFocus(_phoneFocusNode);
      }
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        context.read<SignUpWithPinBloc>().add(PhoneNumberUnfocused());
        // FocusScope.of(context).requestFocus(_pinCodeFocusNode);
      }
    });
    _pinCodeFocusNode.addListener(() {
      if (!_pinCodeFocusNode.hasFocus) {
        context.read<SignUpWithPinBloc>().add(PinCodeUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _pinCodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpWithPinBloc,SignUpWithPinState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<AddressSelectionCubit>().getAddresses();
          Navigator.of(context).pushNamedAndRemoveUntil(
            RoutesConstant.homeLanding,
                (route) => false,
          );
        } else if (state.status.isFailure) {
          showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsConstants.createAccount.tr()),
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingValues.p24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
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
                    phoneNumberFocusNode: _phoneFocusNode,
                  ),
                  SizedBox(height: 20.r),
                  PinCodeWidget(
                    pinCodeFocusNode:_pinCodeFocusNode,
                    pinCodeTextController:  _pinCodeTextController,
                  ),
                  SizedBox(height: 24.r),
                  const SignUpButtonWidget(),
                  SizedBox(height: 24.r),
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
    return BlocBuilder<SignUpWithPinBloc, SignUpWithPinState>(
      builder: (context, state) {
        return state.status == FormzSubmissionStatus.inProgress
            ? const CustomLoader()
            : ReusableElevatedButton(
                title: StringsConstants.signUp.tr(),
                foreGroundColor: ColorsConstants.white,
                disabledBackGroundColor: ColorsConstants.semiLightBlack,
                onPressed: state.isValid
                    ? () {
                        context.read<SignUpWithPinBloc>().add(FormSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    super.key,
    required TextEditingController pinCodeTextController,
    required FocusNode pinCodeFocusNode,
  })  : _pinCodeTextController = pinCodeTextController,
        _pinCodeFocusNode = pinCodeFocusNode;

  final TextEditingController _pinCodeTextController;
  final FocusNode _pinCodeFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpWithPinBloc, SignUpWithPinState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.pinCode.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.pinCode.displayError != null
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
            PinWidget(
              controller: _pinCodeTextController,
              focusNode: _pinCodeFocusNode,
              onChanged:  (value) {
                context.read<SignUpWithPinBloc>().add(PinCodeChanged(pinCode: value));

              },
            )
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
    required FocusNode phoneNumberFocusNode,
  })  : _phoneNumberTextController = phoneNumberTextController,
        _phoneNumberFocusNode = phoneNumberFocusNode;

  final TextEditingController _phoneNumberTextController;
  final FocusNode _phoneNumberFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpWithPinBloc, SignUpWithPinState>(
      buildWhen: (previous, current) {
        return previous.phoneNumber != current.phoneNumber || previous.countryDataModel != current.countryDataModel;
      },
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
              textEditingController: _phoneNumberTextController,
              focusNode: _phoneNumberFocusNode,
              onChanged: (value) {
                context.read<SignUpWithPinBloc>().add(PhoneNumberChanged(phoneNumber: value));
              },
              isEnabled: true,
              hintText: StringsConstants.enterYourPhoneNumber.tr(),
              errorText: state.phoneNumber.displayError != null ? '' : null,
              filledColor: state.phoneNumber.displayError != null
                  ? ColorsConstants.red.withOpacity(0.2)
                  : ColorsConstants.lighterBlack,
              prefixWidget: InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (contextX) {
                      return CodeSelectionWidget(
                        currentCountyCode: state.countryDataModel.code,
                        onPressed: (index) {
                          context.read<SignUpWithPinBloc>().add(CountryCodeChanged(
                            countryDataModel: CountryUtility.countriesDataList[index],
                          ));
                        },
                      );
                    },
                  );
                },
                child: PhonePrefixWidget(
                  countryDataModel: state.countryDataModel,
                ),
              ),
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
    return BlocBuilder<SignUpWithPinBloc, SignUpWithPinState>(
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
              textEditingController: _emailTextController,
              focusNode: _emailFocusNode,
              isEnabled: true,
              hintText: StringsConstants.enterYourEmailAddress.tr(),
              onChanged: (value) {
                context.read<SignUpWithPinBloc>().add(EmailChanged(email: value));
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
    return BlocBuilder<SignUpWithPinBloc, SignUpWithPinState>(
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
                context.read<SignUpWithPinBloc>().add(LastNameChanged(lastName: value));
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
    return BlocBuilder<SignUpWithPinBloc, SignUpWithPinState>(
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
                context.read<SignUpWithPinBloc>().add(FirstNameChanged(firstName: value));
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
