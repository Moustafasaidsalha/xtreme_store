import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/login_with_pin_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/login_with_pin_state.dart';
import 'package:extreme_store/presentation/authentication/widgets/aut_app_bar.dart';
import 'package:extreme_store/presentation/authentication/widgets/auth_bottom_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusabel_text_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/pin_widget.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

import '../../../app/utilities/country_utility.dart';
import '../../addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import '../../common_widgets/country_widgets/code_selection.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/events/login_with_pin_events.dart';
import '../widgets/custom_loader.dart';
import '../widgets/phone_prefix_widget.dart';

class LoginWithPinPage extends StatefulWidget {
  const LoginWithPinPage({super.key});

  @override
  State<LoginWithPinPage> createState() => _LoginWithPinPageState();
}

class _LoginWithPinPageState extends State<LoginWithPinPage> {
  final _phoneNumberTextController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _pinCodeTextController = TextEditingController();
  final _pinCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode.addListener(() {
      if (!_phoneNumberFocusNode.hasFocus) {
        context.read<LoginWithPinBloc>().add(PhoneNumberUnfocused());
      }
    });
    _pinCodeFocusNode.addListener(() {
      if (!_pinCodeFocusNode.hasFocus) {
        context.read<LoginWithPinBloc>().add(PinCodeUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _pinCodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginWithPinBloc, LoginWithPinState>(
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
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showCustomSnackBar(context, state.message);
          });
        }else if (state.status.isCanceled) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RoutesConstant.homeLanding,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AuthAppBar(title: StringsConstants.welcomeBack.tr()),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingValues.p24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15.r),
                Text(
                  StringsConstants.pleaseLoginToYourAccount.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(flex: 1, child: SizedBox()),
                PhoneNumberWidget(
                  phoneNumberTextController: _phoneNumberTextController,
                  phoneNumberFocusNode: _phoneNumberFocusNode,
                ),
                SizedBox(height: 24.r),
                PinCodeWidget(pinCodeTextController: _pinCodeTextController, pinCodeFocusNode: _pinCodeFocusNode),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ReusableTextButton(title: StringsConstants.forgetYourPin.tr(), onPressed: (){
                      Navigator.of(context).pushNamed(RoutesConstant.resetPassword);
                    }),
                  ],
                ),
                SizedBox(height: 24.r),
                const LoginButtonWidget(),
                SizedBox(height: 24.r),
                Expanded(
                  flex: 2,
                  child: AuthBottomButton(
                    title: StringsConstants.youDoNotHaveAccount.tr(),
                    pageName: StringsConstants.signUp.tr(),
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutesConstant.signUpWithPin);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginWithPinBloc, LoginWithPinState>(
      buildWhen: (previous, current) {
        return previous.status != current.status || previous.isValid != current.isValid;
      },
      builder: (context, state) {
        return state.status == FormzSubmissionStatus.inProgress
            ? const CustomLoader()
            : ReusableElevatedButton(
                disabledBackGroundColor: ColorsConstants.semiLightBlack,
                title: StringsConstants.login.tr(),
                foreGroundColor: ColorsConstants.white,
                onPressed: state.isValid
                    ? () {
                        context.read<LoginWithPinBloc>().add(FormSubmitted());
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
    return BlocBuilder<LoginWithPinBloc, LoginWithPinState>(
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
              onChanged: (value) {
                context.read<LoginWithPinBloc>().add(PinCodeChanged(pinCode: value));
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
    return BlocBuilder<LoginWithPinBloc, LoginWithPinState>(
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
                context.read<LoginWithPinBloc>().add(PhoneNumberChanged(phoneNumber: value));
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
                          context.read<LoginWithPinBloc>().add(CountryCodeChanged(
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
