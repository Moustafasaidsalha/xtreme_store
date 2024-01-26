import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/verify_user_bloc.dart';
import 'package:extreme_store/presentation/authentication/model_view/states/verify_user_states.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/constants/values_manager.dart';
import '../../../app/routes/routes_constants.dart';
import '../../common_widgets/buttons/reusable_elevated_button.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../../common_widgets/text_fields/rounded_text_field.dart';
import '../model_view/events/verify_user_event.dart';

class VerifyUserArgs {
  final String phoneNumber;
  final String countryCode;
  final String type;

  VerifyUserArgs({
    required this.phoneNumber,
    required this.countryCode,
    required this.type,
  });
}

class VerifyUserPage extends StatefulWidget {
  const VerifyUserPage({super.key});

  @override
  State<VerifyUserPage> createState() => _VerifyUserPageState();
}

class _VerifyUserPageState extends State<VerifyUserPage> {
  final _codeTextController = TextEditingController();
  final _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _codeFocusNode.addListener(() {
      if (!_codeFocusNode.hasFocus) {
        context.read<VerifyUserBloc>().add(CodeUnfocused());
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
    return BlocListener<VerifyUserBloc, VerifyUserState>(
      listenWhen: (previous, current) {
        return previous.verifyStatus != current.verifyStatus ||
            previous.resendStatus != current.resendStatus;
      },
      listener: (context, state) {
        if (state.verifyStatus.isFailure) {
          showCustomSnackBar(context, state.errorMessage);
        } else if (state.verifyStatus.isSuccess) {
          context.read<AddressSelectionCubit>().getAddresses();
          Navigator.of(context).pushNamedAndRemoveUntil(
            RoutesConstant.homeLanding,
            (route) => false,
          );
        } else if (state.resendStatus.isFailure) {
          showCustomSnackBar(context, state.errorMessage);
        } else if (state.resendStatus.isSuccess) {
          showCustomSnackBar(context, state.errorMessage);
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
                  onChanged: (p0) {
                    context.read<VerifyUserBloc>().add(CodeChanged(code: p0));
                  },
                ),
                SizedBox(height: 30.r),
                VerifyButtonWidget(codeTextController: _codeTextController),
                SizedBox(height: 30.r),
                const Expanded(flex: 1, child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringsConstants.didNotGetCode.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        BlocBuilder<VerifyUserBloc, VerifyUserState>(
                          builder: (context, state) {
                            return state.resendStatus.isInProgress
                                ? const CustomLoader()
                                : GestureDetector(
                                    onTap: () {
                                      context.read<VerifyUserBloc>().add(ResendCode());
                                    },
                                    child: Text(
                                      " ${StringsConstants.resend.tr()}",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  );
                          },
                        )
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
    required TextEditingController codeTextController,
  }) : _codeTextController = codeTextController;
  final TextEditingController _codeTextController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyUserBloc, VerifyUserState>(
      builder: (context, state) {
        if (state.verifyStatus == FormzSubmissionStatus.inProgress) {
          return const CustomLoader();
        } else {
          return ReusableElevatedButton(
            disabledBackGroundColor: ColorsConstants.semiLightBlack,
            title: StringsConstants.verify.tr(),
            foreGroundColor: ColorsConstants.white,
            onPressed: _codeTextController.text.isNotEmpty
                ? () {
                    context.read<VerifyUserBloc>().add(VerifyUserFormSubmitted());
                  }
                : null,
          );
        }
      },
    );
  }
}
