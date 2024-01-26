import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    super.key,
    required this.total,
    required this.currency,
    required this.subTotal,
    required this.numOfItems,
    required this.shippingFees,
    required this.cashOnDelivery,
    required this.discountAmount,
  });
  // final CartEntity cartEntity;
  final double total;
  final String currency;
  final double subTotal;
  final int numOfItems;
  final double shippingFees;
  final double cashOnDelivery;
  final double discountAmount;

  @override
  Widget build(BuildContext context) {
    String itemWord = numOfItems > 1 ? StringsConstants.items.tr() : StringsConstants.item.tr();
    String shippingWord = !CountryUtility.isBaseCountry(currency: currency) ? StringsConstants.shippingFee.tr() : StringsConstants.delivery.tr();
    return Container(
      decoration: ShapeDecoration(
        color: ColorsConstants.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 24.r, bottom: 14.r, left: 20.r, right: 20.r),
        child: Column(
          children: [
            SubTotalItem(
                title: '${StringsConstants.subTotal.tr()} ($numOfItems $itemWord)', value: '$subTotal $currency'),
            SizedBox(height: 16.r),
            shippingFees != 0 ? SubTotalItem(title: shippingWord, value: '$shippingFees $currency') : const SizedBox(),
            shippingFees != 0 ? SizedBox(height: 16.r) : const SizedBox(),
            cashOnDelivery != 0
                ? SubTotalItem(title: StringsConstants.cashOnDelivery.tr(), value: '$cashOnDelivery $currency')
                : const SizedBox(),
            cashOnDelivery != 0 ? SizedBox(height: 16.r) : const SizedBox(),
            discountAmount != 0
                ? SubTotalItem(
                    title: StringsConstants.coupon.tr(),
                    value: '$discountAmount- $currency',
                    textColor: ColorsConstants.green,
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: const Divider(),
            ),
            TotalItem(total: "$total", currency: currency),
          ],
        ),
      ),
    );
  }
}

class TotalItem extends StatelessWidget {
  const TotalItem({
    super.key,
    required this.total,
    required this.currency,
  });

  final String total;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(StringsConstants.total.tr(), style: Theme.of(context).textTheme.titleMedium),
        Text('$total $currency', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class SubTotalItem extends StatelessWidget {
  final String title;
  final String value;
  final Color? textColor;

  const SubTotalItem({
    super.key,
    required this.title,
    required this.value,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor ?? ColorsConstants.black),
        ),
      ],
    );
  }
}

// class TotalSummaryWidget extends StatelessWidget {
//   const TotalSummaryWidget({
//     super.key,
//     required this.cartEntity,
//   });
//   final CartEntity cartEntity;
//   @override
//   Widget build(BuildContext context) {
//     String itemWord = cartEntity.products.length > 1
//         ? StringsConstants.items.tr()
//         : StringsConstants.item.tr();
//     String shippingWord = isGCCApp
//         ? StringsConstants.shippingFee.tr()
//         : StringsConstants.delivery.tr();
//     return Container(
//       decoration: ShapeDecoration(
//         color: ColorsConstants.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
//       ),
//       child: Padding(
//         padding:
//         EdgeInsets.only(top: 24.r, bottom: 14.r, left: 20.r, right: 20.r),
//         child: Column(
//           children: [
//             SubTotalItem(
//                 title:
//                 '${StringsConstants.subTotal.tr()} (${cartEntity.products.length} $itemWord)',
//                 value: '${cartEntity.subTotal} ${cartEntity.currency}'),
//             SizedBox(height: 16.r),
//             cartEntity.shippingFees != 0
//                 ? SubTotalItem(
//                 title: shippingWord,
//                 value: '${cartEntity.shippingFees} ${cartEntity.currency}')
//                 : const SizedBox(),
//             cartEntity.shippingFees != 0
//                 ? SizedBox(height: 16.r)
//                 : const SizedBox(),
//             cartEntity.coupon != 0
//                 ? SubTotalItem(
//               title: StringsConstants.coupon.tr(),
//               value: '${cartEntity.coupon}- ${cartEntity.currency}',
//               textColor: ColorsConstants.green,
//             )
//                 : const SizedBox(),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 12.r),
//               child: const Divider(),
//             ),
//             TotalItem(
//                 total: "${cartEntity.total}", currency: cartEntity.currency),
//           ],
//         ),
//       ),
//     );
//   }
// }
