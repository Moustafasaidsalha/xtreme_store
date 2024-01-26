import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/constants/colors_constants.dart';
import '../../../../app/constants/icon_constants.dart';
import '../../../../app/constants/strings_constants.dart';
import '../../../../app/enums/state_status.dart';
import '../../../authentication/widgets/custom_loader.dart';
import '../../../common_widgets/text_fields/rounded_text_field.dart';
import '../../model_view/add_new_address_bloc/add_new_address_bloc.dart';
import '../../model_view/add_new_address_bloc/add_new_address_event.dart';
import '../../model_view/add_new_address_bloc/add_new_address_state.dart';

class AreaSelectionWidget extends StatelessWidget {
  const AreaSelectionWidget({
    super.key,
    required TextEditingController areaTextController,
  }) : _areaTextController = areaTextController;

  final TextEditingController _areaTextController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
      buildWhen: (previous, current) {
        return previous.selectedAreaModel != current.selectedAreaModel ||
            previous.currentCountryID != current.currentCountryID;
      },
      builder: (context, state) {
        _areaTextController.text = state.selectedAreaModel.areaNameAR ?? '';
        return SelectAreaWidget(
          title: StringsConstants.area.tr(),
          textEditingController: _areaTextController,
          onTap: () async {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (xContext) => BlocProvider.value(
                value: context.read<AddNewAddressBloc>(),
                child: SelectArea(
                  currentCounty: state.currentCountryID,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SelectArea extends StatefulWidget {
  const SelectArea({super.key, required this.currentCounty});
  final int currentCounty;

  @override
  State<SelectArea> createState() => _SelectAreaState();
}

class _SelectAreaState extends State<SelectArea> {
  @override
  void initState() {
    context.read<AddNewAddressBloc>().add(GetAreas(
          countryId: widget.currentCounty,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: ColorsConstants.white,
      content: SizedBox(
        width: 0.9.sw,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  StringsConstants.selectArea.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(IconsConstants.closeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                )
              ],
            ),
            SizedBox(height: 24.h),
            RoundedTextField(
              isEnabled: true,
              hintText: 'Search area',
              onChanged: (p0) {
                context.read<AddNewAddressBloc>().add(SearchAreaEvent(searchKeyWord: p0));
              },
            ),
            SizedBox(height: 12.r),
            Expanded(
              child: BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
                builder: (context, state) {
                  if (state.areaStatus == StateStatus.success) {
                    return ListView.separated(
                      itemCount: state.areas.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.read<AddNewAddressBloc>().add(SelectAreaEvent(
                                  areaModel: state.areas[index],
                                ));
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.areas[index].areaNameAR ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    );
                  } else if (state.areaStatus == StateStatus.loading) {
                    return const Center(child: CustomLoader());
                  } else if (state.areaStatus == StateStatus.failure) {
                    return const Center(child: Text('error'));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectAreaWidget extends StatelessWidget {
  const SelectAreaWidget({
    super.key,
    required this.title,
    required this.textEditingController,
    this.isOptional = false,
    required this.onTap,
  });
  final String title;
  final bool isOptional;
  final TextEditingController textEditingController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Text(
            '$title ${isOptional ? StringsConstants.optional.tr() : '*'}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: RoundedTextField(
            textEditingController: textEditingController,
            isEnabled: false,
            hintText: 'Select Area',
            haveSuffix: true,
            suffixIcon: IconsConstants.arrowDownIC,
          ),
        ),
      ],
    );
  }
}
