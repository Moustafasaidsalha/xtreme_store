import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/authentication/pages/verify_user_page.dart';
import 'package:extreme_store/presentation/authentication/widgets/auth_bottom_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';

import '../../../app/constants/icon_constants.dart';
import '../../../app/utilities/country_utility.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/bloc/phone_sign_up_bloc.dart';
import '../model_view/events/phone_sign_up_events.dart';
import '../model_view/states/phone_sign_up_states.dart';
import '../widgets/country_code_item.dart';
import '../widgets/custom_loader.dart';
import '../widgets/phone_prefix_widget.dart';

class PhoneSignUpPage extends StatefulWidget {
  const PhoneSignUpPage({super.key});

  @override
  State<PhoneSignUpPage> createState() => _PhoneSignUpPageState();
}

class _PhoneSignUpPageState extends State<PhoneSignUpPage> {
  final _phoneNumberTextController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode.addListener(() {
      if (!_phoneNumberFocusNode.hasFocus) {
        context.read<PhoneSignUpBloc>().add(PhoneNumberUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneSignUpBloc, PhoneSignUpState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pushNamed(RoutesConstant.verifyUser,
              arguments: VerifyUserArgs(
                phoneNumber: state.phoneNumber.value,
                countryCode: state.countryDataModel.code,
                type: 'signup',
              ));
        } else if (state.status.isFailure) {
          showCustomSnackBar(context, state.errorMessage);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:  Text(StringsConstants.createAccount.tr()),
          titleSpacing: 0,
        ),
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
                  StringsConstants.letsCreateYourAccount.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(flex: 1, child: SizedBox()),
                PhoneNumberWidget(
                  phoneNumberTextController: _phoneNumberTextController,
                  phoneNumberFocusNode: _phoneNumberFocusNode,
                ),
                SizedBox(height: 24.r),
                const PhoneSignUpButtonWidget(),
                SizedBox(height: 24.r),
                Expanded(
                  flex: 2,
                  child: AuthBottomButton(
                    title: StringsConstants.alreadyMember.tr(),
                    pageName: StringsConstants.login.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
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

class PhoneSignUpButtonWidget extends StatelessWidget {
  const PhoneSignUpButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneSignUpBloc, PhoneSignUpState>(
      buildWhen: (previous, current) {
        return previous.status != current.status || previous.isValid != current.isValid;
      },
      builder: (context, state) {
        return state.status == FormzSubmissionStatus.inProgress
            ? const CustomLoader()
            : ReusableElevatedButton(
                disabledBackGroundColor: ColorsConstants.semiLightBlack,
                title: StringsConstants.signUp.tr(),
                foreGroundColor: ColorsConstants.white,
                onPressed: state.isValid
                    ? () {
                        context.read<PhoneSignUpBloc>().add(FormSubmitted());
                      }
                    : null,
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
    return BlocBuilder<PhoneSignUpBloc, PhoneSignUpState>(
      buildWhen: (previous, current) {
        return previous.phoneNumber != current.phoneNumber ||
            previous.countryDataModel != current.countryDataModel;
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
                          StringsConstants.pleaseWriteTheCorrectPhone.tr(),
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
                context.read<PhoneSignUpBloc>().add(PhoneNumberChanged(phoneNumber: value));
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
                      return BlocProvider.value(
                        value: context.read<PhoneSignUpBloc>(),
                        child: CodeSelectionWidget(
                          currentCountyCode: state.countryDataModel.code,
                        ),
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

class CodeSelectionWidget extends StatelessWidget {
  final String currentCountyCode;

  const CodeSelectionWidget({
    super.key,
    required this.currentCountyCode,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: ColorsConstants.white,
      content: SizedBox(
        width: 0.9.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  StringsConstants.selectCountry.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(IconsConstants.closeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                )
              ],
            ),
            SizedBox(height: 40.w),
            ListView.separated(
              shrinkWrap: true,
              itemCount: CountryUtility.countriesDataList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                bool isSelected = currentCountyCode == CountryUtility.countriesDataList[index].code;
                return InkWell(
                  onTap: () {
                    context.read<PhoneSignUpBloc>().add(CountryChanged(
                          countryDataModel: CountryUtility.countriesDataList[index],
                        ));
                    Navigator.of(context).pop();
                  },
                  child: CountryCodeItem(
                    isSelected: isSelected,
                    countryFlagPath: CountryUtility.countriesDataList[index].iconPath,
                    countryName: CountryUtility.countriesDataList[index].nameAR,
                    countryCode: CountryUtility.countriesDataList[index].code,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: ColorsConstants.gray.withOpacity(0.15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
