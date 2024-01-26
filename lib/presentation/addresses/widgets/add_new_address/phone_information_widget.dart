import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/constants/colors_constants.dart';
import '../../../../app/constants/icon_constants.dart';
import '../../../../app/constants/strings_constants.dart';
import '../../../../app/enums/state_status.dart';
import '../../../../app/utilities/country_utility.dart';
import '../../../authentication/widgets/custom_loader.dart';
import '../../../authentication/widgets/phone_prefix_widget.dart';
import '../../../common_widgets/checks/check_widget.dart';
import '../../../common_widgets/text_fields/rounded_text_field.dart';
import '../../model_view/add_new_address_bloc/add_new_address_bloc.dart';
import '../../model_view/add_new_address_bloc/add_new_address_event.dart';
import '../../model_view/add_new_address_bloc/add_new_address_state.dart';

class PhoneInformationWidget extends StatelessWidget {
  const PhoneInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
      buildWhen: (previous, current) {
        return previous.selectedPhoneNumber != current.selectedPhoneNumber ||
            previous.currentCountryID != current.currentCountryID;
      },
      builder: (context, state) {
        if (state.selectedPhoneNumber.phoneNumber?.isNotEmpty ?? false) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsConstants.phoneNumber.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${state.selectedPhoneNumber.countryCode} ${state.selectedPhoneNumber.phoneNumber}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (xContext) {
                          return BlocProvider.value(
                            value: context.read<AddNewAddressBloc>(),
                            child: PhoneNumberSelectionWidget(
                              currentPhoneNumber: state.selectedPhoneNumber.phoneNumber ?? '',
                              currentCountryID: state.currentCountryID,
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      '( Change )',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorsConstants.blue,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}

class PhoneNumberSelectionWidget extends StatefulWidget {
  final String currentPhoneNumber;
  final int currentCountryID;
  const PhoneNumberSelectionWidget({
    super.key,
    required this.currentPhoneNumber,
    required this.currentCountryID,
  });

  @override
  State<PhoneNumberSelectionWidget> createState() => _PhoneNumberSelectionWidgetState();
}

class _PhoneNumberSelectionWidgetState extends State<PhoneNumberSelectionWidget> {
  final _phoneNumberTextController = TextEditingController();
  final _codeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String countryCode = CountryUtility.countriesDataList
    //     .firstWhere(
    //       (element) => element.id == widget.currentCountryID,
    //     )
    //     .code;
    return AlertDialog(
      surfaceTintColor: ColorsConstants.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 14),
      content: SizedBox(
        width: 0.9.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select phone number',
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
            SizedBox(height: 24.w),
            BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
              buildWhen: (previous, current) {
                return previous.isLoadingOTP != current.isLoadingOTP ||
                    previous.addPhoneMessage != current.addPhoneMessage;
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Add new phone number"),
                    const SizedBox(height: 8),
                    RoundedTextFieldWithSuffixWidget(
                      textEditingController: _phoneNumberTextController,
                      isEnabled: true,
                      hintText: StringsConstants.enterYourPhoneNumber.tr(),
                      prefixWidget: PhonePrefixWidget(
                        countryDataModel: CountryUtility.countriesDataList.firstWhere(
                          (element) => element.id == widget.currentCountryID,
                        ),
                      ),
                      suffixWidget: InkWell(
                        onTap: () {
                          context.read<AddNewAddressBloc>().add(AddUserPhoneNumbers(
                                phoneNumber: _phoneNumberTextController.text,
                                countryCode: CountryUtility.countriesDataList.firstWhere(
                                      (element) => element.id == widget.currentCountryID,
                                ).code,
                              ));
                        },
                        child: Text(
                          "add",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorsConstants.black,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    state.isLoadingOTP ?  Text(StringsConstants.verify.tr()) : const SizedBox(),
                    const SizedBox(height: 8),
                    state.isLoadingOTP
                        ? RoundedTextFieldWithSuffixWidget(
                            textEditingController: _codeTextController,
                            isEnabled: true,
                            hintText: StringsConstants.enterOTP.tr(),
                            suffixWidget: InkWell(
                              onTap: () {
                                context.read<AddNewAddressBloc>().add(VerifyUserPhoneNumbers(
                                      code: _codeTextController.text,
                                      phoneNumber: _phoneNumberTextController.text,
                                      countryCode: CountryUtility.countriesDataList.firstWhere(
                                            (element) => element.id == widget.currentCountryID,
                                      ).code,
                                    ));
                              },
                              child: Text(
                                StringsConstants.verify.tr(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ColorsConstants.black,
                                    ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 8),
                    Text(state.addPhoneMessage.isEmpty ? '' : state.addPhoneMessage,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: ColorsConstants.red)),
                  ],
                );
              },
            ),
            SizedBox(height: 40.w),
            BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
              buildWhen: (previous, current) {
                return previous.phoneNumberStatus != current.phoneNumberStatus ||
                    previous.userPhoneNumbers != current.userPhoneNumbers ||
                    previous.selectedPhoneNumber != current.selectedPhoneNumber;
              },
              builder: (context, state) {
                if (state.phoneNumberStatus == StateStatus.success) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.userPhoneNumbers.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      bool isSelected =
                          widget.currentPhoneNumber == state.userPhoneNumbers[index].phoneNumber;

                      return InkWell(
                        onTap: () {
                          context.read<AddNewAddressBloc>().add(
                                SelectUserPhoneNumbers(
                                  phoneNumberModel: state.userPhoneNumbers[index],
                                ),
                              );
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            CheckWidget(isSelected: isSelected),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(state.userPhoneNumbers[index].phoneNumber ?? ''),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: ColorsConstants.gray.withOpacity(0.15),
                    ),
                  );
                } else if (state.phoneNumberStatus == StateStatus.loading) {
                  return const Center(child: CustomLoader());
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
