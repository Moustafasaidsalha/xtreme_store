import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/my_account/widgets/account_list.dart';

import '../widgets/header_widget.dart';

class RegisteredAccountPage extends StatelessWidget {
  const RegisteredAccountPage({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                HeaderWidget(userName: userName),
                 SizedBox(height: 20.h,),
                 AccountList(registeredUser: true, userPreferenceRepo: sl(),),
              ],
            ),
            const RegisteredHeaderButtons(),
          ],
        ),
      ),
    );
  }
}

class RegisteredHeaderButtons extends StatelessWidget {
  const RegisteredHeaderButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        children: [
          SizedBox(
            height: 188.h,
          ),
          Row(
            children: [
              RegisteredHeaderButton(
                title: StringsConstants.orders,
                iconPath: IconsConstants.bagIC,
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesConstant.orders);
                },
              ),
              SizedBox(width: 32.w),
              RegisteredHeaderButton(
                title: StringsConstants.addresses,
                iconPath: IconsConstants.locationSolidIC,
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesConstant.addresses);
                },
              ),
              SizedBox(width: 32.w),
              RegisteredHeaderButton(
                title: StringsConstants.wishlist,
                iconPath: IconsConstants.heartIC,
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesConstant.wishlist);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisteredHeaderButton extends StatelessWidget {
  const RegisteredHeaderButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 98.w,
            height: 84.h,
            decoration: ShapeDecoration(
              color: ColorsConstants.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              shadows: const [
                BoxShadow(
                  color: ColorsConstants.shadow,
                  blurRadius: 12,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.w),
              child: SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
