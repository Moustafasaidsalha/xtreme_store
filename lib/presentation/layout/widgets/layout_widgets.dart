import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/utilities/extension.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/di/injection_container.dart';
import '../../../domain/repositories/user_preference_repo.dart';
import '../model_view/layout_cubit.dart';
import '../model_view/layout_states.dart';

Widget bottomNavigationBarWidget({
  required BuildContext context,
}) {
  return BlocBuilder<LayoutCubit, LayoutStates>(builder: (context, state) {
    List<BottomNavigationBarItem> items = List.generate(
        LayoutCubit.get(context).item.length,
        (index) => BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    LayoutCubit.get(context).item.values.elementAt(index),
                    colorFilter: ColorFilter.mode(
                      // index == LayoutCubit.get(context).bottomNavIndex
                      //     ? const Color(0xFF000000)
                      //     : Colors.grey,
                      index == LayoutCubit.get(context).bottomNavIndex ? sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():const Color(0xFF000000) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  // index == 2
                  //     ? Positioned(
                  //         top: 0,
                  //         right: 0,
                  //         child: CircleAvatar(
                  //           backgroundColor: Colors.blue,
                  //           maxRadius: 5.r,
                  //         ),
                  //       )
                  //     : SizedBox()
                ],
              ),
            ),
            label: LayoutCubit.get(context).item.keys.elementAt(index).tr()));

    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,

      // selectedItemColor: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,
      selectedItemColor: ColorsConstants.black,
      unselectedLabelStyle:  TextStyle(
        // color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty ?sl<UserPreferenceRepo>().getMainColor().toColor():ColorsConstants.black,
        color: ColorsConstants.black,
        fontSize: 11.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: ColorsConstants.white,
      onTap: (value) {
        LayoutCubit.get(context)
            .changeBottomNav(value: value, context: context);
      },
      items: items,
      currentIndex: LayoutCubit.get(context).bottomNavIndex,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        color: sl<UserPreferenceRepo>().getMainColor().isNotEmpty
            ? sl<UserPreferenceRepo>().getMainColor().toColor()
            : ColorsConstants.black,
        fontSize: 11.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      ),
    );
  });
}
