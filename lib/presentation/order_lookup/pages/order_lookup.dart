import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/rounded_text_field.dart';
import 'package:extreme_store/presentation/order_lookup/model_view/order_lookup_cubit.dart';

class OrderLookupPage extends StatelessWidget {
  const OrderLookupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWithActionButton(
        title: StringsConstants.orderLookup.tr(),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
SizedBox(height: 11.h,),
            Text("Order code can be found in my orders page, after placing an order",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: FontSize.s15.sp,height: 1.33.h),),
            SizedBox(height: 47.h,),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                "order code",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            RoundedTextField(
              textEditingController: OrderLookupCubit.get(context).controller,
              isEnabled: true,
              hintText: "Enter order code here",
            ),
            SizedBox(height: 47.h,),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 11.w),
              child: ReusableElevatedButton(title: "Order look up", onPressed: () {
Navigator.of(context).pushNamed(RoutesConstant.trackOrder);
              },),
            )


          ],
        ),
      ),

    );
  }
}
