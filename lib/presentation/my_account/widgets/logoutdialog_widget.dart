import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/my_account/model_view/account_cubit.dart';

import '../../common_widgets/buttons/reusabel_text_button.dart';
import '../../common_widgets/dialogs/dialogs.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 327.w,
        height: 195.h,
        decoration: const BoxDecoration(color: ColorsConstants.white),
        padding: EdgeInsets.only(top: 37.h, left: 19.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringsConstants.logoutQuestion.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 35.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: ReusableElevatedButton(
                    roundedCorner: 0,
                    title: StringsConstants.logout.tr(),
                    onPressed: () async {
                      final res = await context.read<AccountCubit>().doLogout();
                      res.fold(
                              (l) {
                            Navigator.of(context).pop();
                            showCustomSnackBar(context, l.message);
                          },
                              (r) {
                            context.read<AddressSelectionCubit>().getAddresses();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              RoutesConstant.loginWithPin,
                                  (route) => false,
                            );
                          });
                    },
                  ),
                ),
                SizedBox(
                  width: 60.w,
                ),
                ReusableTextButton(
                  title: StringsConstants.cancel.tr(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
