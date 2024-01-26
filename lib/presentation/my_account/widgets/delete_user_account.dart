import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';

import '../../addresses/model_view/address_selection_cubit/address_selection_cubit.dart';
import '../../common_widgets/buttons/reusabel_text_button.dart';
import '../../common_widgets/dialogs/dialogs.dart';
import '../model_view/account_cubit.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key, });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 327.w,
        height: 195.h,
        decoration: const BoxDecoration(color: ColorsConstants.white),
        padding: EdgeInsets.only(top: 37.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringsConstants.deleteAccountQuestion.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 35.h,
            ),
            Row(
              children: [
                Expanded(
                  child: ReusableElevatedButton(
                    roundedCorner: 0,
                    title: StringsConstants.delete.tr(),
                    onPressed: () async {
                      final res = await context.read<AccountCubit>().doDeleteAccount();
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
                            },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Expanded(
                  child: ReusableTextButton(
                    title: StringsConstants.cancel.tr(),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
