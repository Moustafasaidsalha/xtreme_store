import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/constants/colors_constants.dart';
import '../../../../app/constants/fonts_constants.dart';
import '../../../../app/constants/icon_constants.dart';
import '../../../../app/constants/strings_constants.dart';
import '../../../../app/enums/state_status.dart';
import '../../../authentication/widgets/custom_loader.dart';
import '../../model_view/add_new_address_bloc/add_new_address_bloc.dart';
import '../../model_view/add_new_address_bloc/add_new_address_state.dart';

class FullAddressWidget extends StatelessWidget {
  const FullAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAddressBloc, AddNewAddressState>(
      buildWhen: (previous, current) {
        return previous.addressFullNameStatus != current.addressFullNameStatus ||
            previous.fullAddress != current.fullAddress;
      },
      builder: (context, state) {
        return state.addressFullNameStatus == StateStatus.success
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      state.fullAddress,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 0.3.sw,
                    height: 0.3.sw,
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            bearing: 5.0,
                            target: LatLng(
                              state.currentLatLang.latitude,
                              state.currentLatLang.longitude,
                            ),
                            tilt: 0.0,
                            zoom: 17,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop(state.currentLatLang);
                            },
                            child: Container(
                              color: ColorsConstants.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      IconsConstants.editIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      StringsConstants.edit.tr(),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontSize: FontSize.s12.sp,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomLoader(),
                  ),
                ],
              );
      },
    );
  }
}
