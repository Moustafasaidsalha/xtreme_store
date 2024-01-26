import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/change_pin_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/events/change_pin_events.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/change_pin_state.dart';
import 'package:extreme_store/presentation/authentication/pages/verify_successful_page.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';

import '../../../app/routes/routes_constants.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../../common_widgets/text_fields/pin_widget.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({
    super.key,
  });

  @override
  State<ChangePinPage> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePinPage> {
  final _oldPinTextController = TextEditingController();
  final _oldPinFocusNode = FocusNode();
  final _newPinTextController = TextEditingController();
  final _newPinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _oldPinFocusNode.addListener(() {
      if (!_oldPinFocusNode.hasFocus) {
        context.read<ChangePinBloc>().add(OldPinUnfocused());
      }
    });
    _newPinFocusNode.addListener(() {
      if (!_newPinFocusNode.hasFocus) {
        context.read<ChangePinBloc>().add(NewPinUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _oldPinTextController.dispose();
    _oldPinFocusNode.dispose();
    _newPinTextController.dispose();
    _newPinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePinBloc, ChangePinState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          showCustomSnackBar(context, state.message);
        } else if (state.status == FormzSubmissionStatus.success) {
          Navigator.of(context).pushNamed(
            RoutesConstant.verifySuccessful,
            arguments: VerifySuccessfulArgs(
              message: StringsConstants.successfulChangedPassword.tr(),
              onTapDone: () {
                context.read<AddressSelectionCubit>().getAddresses();
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
                  StringsConstants.resetYourPin.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // SizedBox(height: 15.r),
                // Text(
                //   StringsConstants.resetPasswordTips.tr(),
                //   style: Theme.of(context).textTheme.bodySmall,
                // ),
                const Expanded(flex: 1, child: SizedBox()),
                SizedBox(height: 24.w),
                OldPinCodeWidget(
                  pinCodeTextController: _oldPinTextController,
                  pinCodeFocusNode: _oldPinFocusNode,
                ),
                SizedBox(height: 12.w),
                NewPinCodeWidget(
                  pinCodeTextController: _newPinTextController,
                  pinCodeFocusNode: _newPinFocusNode,
                ),
                SizedBox(height: 24.w),
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

class OldPinCodeWidget extends StatelessWidget {
  const OldPinCodeWidget({
    super.key,
    required TextEditingController pinCodeTextController,
    required FocusNode pinCodeFocusNode,
  })  : _pinCodeTextController = pinCodeTextController,
        _pinCodeFocusNode = pinCodeFocusNode;

  final TextEditingController _pinCodeTextController;
  final FocusNode _pinCodeFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePinBloc, ChangePinState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.oldPinCode.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.oldPin.displayError != null
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
                context.read<ChangePinBloc>().add(OldPinChanged(pinCode: value));
              },
            )
          ],
        );
      },
    );
  }
}

class NewPinCodeWidget extends StatelessWidget {
  const NewPinCodeWidget({
    super.key,
    required TextEditingController pinCodeTextController,
    required FocusNode pinCodeFocusNode,
  })  : _pinCodeTextController = pinCodeTextController,
        _pinCodeFocusNode = pinCodeFocusNode;

  final TextEditingController _pinCodeTextController;
  final FocusNode _pinCodeFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePinBloc, ChangePinState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.newPinCode.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  state.newPin.displayError != null
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
                context.read<ChangePinBloc>().add(NewPinChanged(pinCode: value));
              },
            )
          ],
        );
      },
    );
  }
}

class ResetButtonWidget extends StatelessWidget {
  const ResetButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePinBloc, ChangePinState>(
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const CustomLoader();
        } else {
          return ReusableElevatedButton(
            disabledBackGroundColor: ColorsConstants.semiLightBlack,
            title: StringsConstants.resetYourPin.tr(),
            foreGroundColor: ColorsConstants.white,
            onPressed: state.isValid
                ? () {
                    context.read<ChangePinBloc>().add(ChangePinSubmitted());
                  }
                : null,
          );
        }
      },
    );
  }
}
