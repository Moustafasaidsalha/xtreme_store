import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/presentation/addresses/model_view/map_cubit/map_cubit.dart';
import 'package:extreme_store/presentation/addresses/model_view/map_cubit/map_states.dart';
import 'package:extreme_store/presentation/authentication/widgets/custom_loader.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';

import '../../../app/routes/routes_constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: ColorsConstants.backGround,
            child: BlocBuilder<MapCubit, MapStates>(
              buildWhen: (previous, current) {
                return previous.currentLatLang != current.currentLatLang ||
                    previous.markers != current.markers;
              },
              builder: (context, state) {
                if (state.mapStates == StateStatus.success) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      bearing: 0.0,
                      target: state.currentLatLang,
                      tilt: 0.0,
                      zoom: 17,
                    ),
                    markers: state.markers,
                    onTap: (argument) {
                      context.read<MapCubit>().setNewMarker(latLng: argument);
                    },
                  );
                } else if (state.mapStates == StateStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.mapStates == StateStatus.failure) {
                  return  Center(
                    child: Text(StringsConstants.someThingWrong.tr()),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingValues.p24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AddressAppBar(),
                  const Expanded(child: SizedBox()),
                  BlocBuilder<MapCubit, MapStates>(
                    buildWhen: (previous, current) {
                      return previous.buttonStatus != current.buttonStatus;
                    },
                    builder: (context, state) {
                      if (state.buttonStatus.isInProgress) {
                        return const CustomLoader();
                      } else if (state.buttonStatus.isSuccess) {
                        return ReusableElevatedButton(
                          title: StringsConstants.confirmLocation.tr(),
                          onPressed: () async {
                            context.read<MapCubit>().confirmLocation(
                                  lat: state.currentLatLang.latitude,
                                  long: state.currentLatLang.latitude,
                                );
                            await Navigator.of(context).pushNamed(
                              RoutesConstant.addNewAddress,
                              arguments: state.currentLatLang,
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  SizedBox(height: 28.r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressAppBar extends StatelessWidget {
  const AddressAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          StringsConstants.addAddress.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const ForwardButton(),
      ],
    );
  }
}

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsConstants.white,
          shape: BoxShape.circle,
        ),
        child: context.locale == const Locale("en", "US")
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios_outlined),
              )
            : const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
      ),
    );
  }
}
