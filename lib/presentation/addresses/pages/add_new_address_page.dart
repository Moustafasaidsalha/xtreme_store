import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/data/models/addresses_response_model.dart';
import 'package:extreme_store/presentation/addresses/model_view/add_new_address_bloc/add_new_address_bloc.dart';
import 'package:extreme_store/presentation/addresses/model_view/add_new_address_bloc/add_new_address_state.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';

import '../../../app/enums/state_status.dart';
import '../../../app/routes/routes_constants.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/add_new_address_bloc/add_new_address_event.dart';
import '../widgets/add_new_address/address_item_widget.dart';
import '../widgets/add_new_address/area_selection_widget.dart';
import '../widgets/add_new_address/country_selection_widget.dart';
import '../widgets/add_new_address/full_address_widget.dart';
import '../widgets/add_new_address/phone_information_widget.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key, required this.currentLatLng});
  final LatLng currentLatLng;

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> with SingleTickerProviderStateMixin {
  final _addressNameTextController = TextEditingController();
  final _areaTextController = TextEditingController();
  final _blocTextController = TextEditingController();
  final _streetTextController = TextEditingController();
  final _avenueTextController = TextEditingController();

  ///
  final _houseNumberTextController = TextEditingController();
  final _otherInstructionsTextController = TextEditingController();

  ///
  final _buildingNumberTextController = TextEditingController();
  final _floorNumberTextController = TextEditingController();
  final _aptNumberTextController = TextEditingController();

  ///
  final _officeNumberTextController = TextEditingController();

  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    context.read<AddNewAddressBloc>().add(GetCurrentAddress(
          currentLatLng: widget.currentLatLng,
        ));
    context.read<AddNewAddressBloc>().add(GetUserPhoneNumbers());
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      context.read<AddNewAddressBloc>().add(
            ChangeAddressType(addressType: addressTypeList[_tabController.index]),
          );
      setState(() {});
    }
  }

  final List<String> places = [
    StringsConstants.homeAddressType.tr(),
    StringsConstants.officeAddressType.tr(),
    StringsConstants.buildingAddressType.tr(),
  ];

  List<String> addressTypeList = [
    StringsConstants.house.tr(),
    StringsConstants.office.tr(),
    StringsConstants.building.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewAddressBloc, AddNewAddressState>(
      listenWhen: (previous, current) {
        return previous.submitStatus != current.submitStatus || previous.message != current.message;
      },
      listener: (context, state) {
        if (state.submitStatus == StateStatus.failure) {
          showCustomSnackBar(context, state.message);
        } else if (state.submitStatus == StateStatus.success) {
          showCustomSnackBar(
            context,
            state.message,
          );
          Navigator.popUntil(context, ModalRoute.withName(RoutesConstant.addresses));
        }
      },
      child: Scaffold(
        backgroundColor: ColorsConstants.backGround,
        resizeToAvoidBottomInset: false,
        appBar: AppBarWithActionButton(title: StringsConstants.addNewAddress.tr()),
        body: SafeArea(
          bottom: false,
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          StringsConstants.locationInformation.tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorsConstants.black),
                        ),
                        SizedBox(height: 16.h),
                        const FullAddressWidget(),
                        SizedBox(height: 16.h),
                        Text(
                          StringsConstants.personalInformation.tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorsConstants.black),
                        ),
                        SizedBox(height: 8.h),
                        const PhoneInformationWidget(),
                        SizedBox(height: 16.h),
                        Text(
                          StringsConstants.addressInformation.tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorsConstants.black),
                        ),
                        SizedBox(height: 12.h),
                        const CountrySelectionWidget(),
                        SizedBox(height: 12.h),
                        FullAddressTextFieldWidget(
                            addressNameTextController: _addressNameTextController),
                        SizedBox(height: 12.h),
                        AreaSelectionWidget(areaTextController: _areaTextController),
                        SizedBox(height: 12.h),
                        AddAddressItemWidget(
                          title: StringsConstants.bloc.tr(),
                          textEditingController: _blocTextController,
                        ),
                        SizedBox(height: 12.h),
                        AddAddressItemWidget(
                          title: StringsConstants.street.tr(),
                          textEditingController: _streetTextController,
                        ),
                        SizedBox(height: 12.h),
                        AddAddressItemWidget(
                          title: StringsConstants.avenue.tr(),
                          isOptional: true,
                          textEditingController: _avenueTextController,
                        ),
                        SizedBox(height: 12.h),
                        TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return ColorsConstants.black.withOpacity(0.2);
                              }
                              return null;
                            },
                          ),
                          labelColor: ColorsConstants.white,
                          unselectedLabelColor: ColorsConstants.black,
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                          unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
                          indicator:  BoxDecoration(
                            color: ColorsConstants.black,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs:  [
                            Tab(text: StringsConstants.homeAddressType.tr()),
                            Tab(text: StringsConstants.officeAddressType.tr()),
                            Tab(text: StringsConstants.buildingAddressType.tr()),
                          ],
                        ),
                        Center(
                          child: [
                            HomeAddressWidget(
                              houseNumberEditingController: _houseNumberTextController,
                              otherInstructionEditingController: _otherInstructionsTextController,
                            ),
                            OfficeAddressWidget(
                              buildingNumberEditingController: _buildingNumberTextController,
                              officeEditingController: _officeNumberTextController,
                              floorNumberEditingController: _floorNumberTextController,
                              otherInstructionEditingController: _otherInstructionsTextController,
                            ),
                            BuildingAddressWidget(
                              buildingNumberEditingController: _buildingNumberTextController,
                              aptEditingController: _aptNumberTextController,
                              floorNumberEditingController: _floorNumberTextController,
                              otherInstructionEditingController: _otherInstructionsTextController,
                            ),
                          ][_tabController.index],
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
                  builder: (context, state) {
                    return state.submitStatus == StateStatus.loading
                        ?  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: ColorsConstants.black,
                              )
                            ],
                          )
                        : ReusableElevatedButton(
                            title: StringsConstants.saveAddress.tr(),
                            onPressed: () {
                              var x = AddAddressModel(
                                phoneID: state.selectedPhoneNumber.id,
                                countryID: state.currentCountryID,
                                addressName: state.fullAddress,
                                areaID: state.selectedAreaModel.id,
                                block: _blocTextController.text,
                                street: _streetTextController.text,
                                avenue: _avenueTextController.text,
                                otherInstructions: _otherInstructionsTextController.text,
                                houseNumber: _houseNumberTextController.text, //
                                buildingNumber: _buildingNumberTextController.text, //
                                floorNumber: _floorNumberTextController.text,
                                officeNumber: _officeNumberTextController.text,
                                aptNumber: _aptNumberTextController.text, //
                                type: state.addressType,
                                longitude: state.currentLatLang.longitude,
                                latitude: state.currentLatLang.latitude,
                              );

                              context.read<AddNewAddressBloc>().add(
                                    SaveNewAddress(addAddressModel: x),
                                  );
                            },
                          );
                  },
                ),
                SizedBox(height: 28.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FullAddressTextFieldWidget extends StatelessWidget {
  const FullAddressTextFieldWidget({
    super.key,
    required TextEditingController addressNameTextController,
  }) : _addressNameTextController = addressNameTextController;

  final TextEditingController _addressNameTextController;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState, String>(
      selector: (state) => state.fullAddress,
      builder: (context, state) {
        _addressNameTextController.text = state;
        return AddAddressItemWidget(
          title: StringsConstants.addressName.tr(),
          textEditingController: _addressNameTextController,
          onChanged: (p0) {
            context.read<AddNewAddressBloc>().add(ChangeAddressName(
                  addressName: p0,
                ));
          },
        );
      },
    );
  }
}

class HomeAddressWidget extends StatelessWidget {
  const HomeAddressWidget({
    super.key,
    required this.houseNumberEditingController,
    required this.otherInstructionEditingController,
  });
  final TextEditingController houseNumberEditingController;
  final TextEditingController otherInstructionEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.houseNumber.tr(),
          textEditingController: houseNumberEditingController,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.otherInstructions.tr(),
          textEditingController: otherInstructionEditingController,
          isOptional: true,
        ),
      ],
    );
  }
}

class OfficeAddressWidget extends StatelessWidget {
  const OfficeAddressWidget({
    super.key,
    required this.buildingNumberEditingController,
    required this.officeEditingController,
    required this.floorNumberEditingController,
    required this.otherInstructionEditingController,
  });
  final TextEditingController buildingNumberEditingController;
  final TextEditingController floorNumberEditingController;
  final TextEditingController officeEditingController;
  final TextEditingController otherInstructionEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.buildingNumber.tr(),
          textEditingController: buildingNumberEditingController,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.floorNumber.tr(),
          textEditingController: floorNumberEditingController,
          isOptional: true,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.officeNumber.tr(),
          textEditingController: officeEditingController,
          isOptional: true,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.otherInstructions.tr(),
          textEditingController: otherInstructionEditingController,
          isOptional: true,
        ),
      ],
    );
  }
}

class BuildingAddressWidget extends StatelessWidget {
  const BuildingAddressWidget({
    super.key,
    required this.buildingNumberEditingController,
    required this.aptEditingController,
    required this.floorNumberEditingController,
    required this.otherInstructionEditingController,
  });
  final TextEditingController buildingNumberEditingController;
  final TextEditingController floorNumberEditingController;
  final TextEditingController aptEditingController;
  final TextEditingController otherInstructionEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.buildingNumber.tr(),
          textEditingController: buildingNumberEditingController,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.floorNumber.tr(),
          textEditingController: floorNumberEditingController,
          isOptional: true,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.aptNumber.tr(),
          textEditingController: aptEditingController,
          isOptional: true,
        ),
        SizedBox(height: 12.h),
        AddAddressItemWidget(
          title: StringsConstants.otherInstructions.tr(),
          textEditingController: otherInstructionEditingController,
          isOptional: true,
        ),
      ],
    );
  }
}
