import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';

import '../widgets/account_list.dart';
import '../widgets/header_widget.dart';

class UnRegisteredAccountPage extends StatelessWidget {
  const UnRegisteredAccountPage({
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
                 AccountList(registeredUser: false, userPreferenceRepo: sl(),),
              ],
            ),
            const UnregisteredHeaderButtons(),
          ],
        ),
      ),
    );
  }
}

class UnregisteredHeaderButtons extends StatelessWidget {
  const UnregisteredHeaderButtons({
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
            height: 170.h,
            // height: 188.h,
          ),
          Row(
            children: [
              UnregisteredHeaderButton(
                title: StringsConstants.login.tr(),
                iconPath: IconsConstants.userIC,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesConstant.loginWithPin,
                    (route) => false,
                  );
                },
              ),
              SizedBox(width: 16.w),
              UnregisteredHeaderButton(
                title: StringsConstants.signUp.tr(),
                iconPath: IconsConstants.addUserIC,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesConstant.loginWithPin,
                    (route) => false,
                  );
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class UnregisteredHeaderButton extends StatelessWidget {
  const UnregisteredHeaderButton({
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
      child: Container(
        width: 171.w,
        height: 138.h,
        decoration: ShapeDecoration(
          color: ColorsConstants.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: const [
            BoxShadow(
              color: ColorsConstants.shadow,
              blurRadius: 12,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
            SizedBox(
              height: 25.h,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!,
            )
          ],
        ),
      ),
    );
  }
}
