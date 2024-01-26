import 'package:flutter/material.dart';

class AppBarWithActionButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;

   const AppBarWithActionButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      // automaticallyImplyLeading: false,
      title: Text(
        title,
      ),
      // actions: [
      //   IconButton(
      //       padding: EdgeInsets.symmetric(horizontal: AppSize.s21.w),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //       icon: SvgPicture.asset(IconsConstants.arrowRightBarIC))
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
