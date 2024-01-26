import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/authentication/model_view/bloc/login_with_pin_bloc.dart';

import '../../addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import '../model_view/events/login_with_pin_events.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AuthAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        GestureDetector(
          onTap: () {
            context.read<AddressSelectionCubit>().getAddresses();
            context.read<LoginWithPinBloc>().add(EscapeAuth());
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   RoutesConstant.homeLanding,
            //   (route) => false,
            // );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingValues.p24.r),
            child: Text(
              StringsConstants.skip.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
