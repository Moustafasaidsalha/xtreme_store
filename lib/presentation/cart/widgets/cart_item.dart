import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/elevated_icon_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.productModel,
    required this.currency,
    super.key,
  });
  final SubCarts productModel;
  final String currency;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");
    return Container(
      height: 175.h,
      color: ColorsConstants.white,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 111.w,
                  child: Image.network(
                    productModel.product?.images?.first.url ?? '',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        SvgPicture.asset(IconsConstants.placeholder),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAr
                            ? productModel.product?.brand?.nameAr ?? ""
                            : productModel.product?.brand?.nameEn ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        isAr
                            ? productModel.product?.nameAr ?? ""
                            : productModel.product?.nameEn ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      (productModel.product?.offer ?? false)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${productModel.product?.offerPrice} $currency',
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                SizedBox(width: 20.r),
                                Text(
                                  '${productModel.product?.price} $currency',
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${productModel.product?.price} $currency',
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomIconButton(
                iconPath: Icons.remove,
                onTap: (productModel.amount ?? 1) > 1 ? () {
                  context.read<CartCubit>().minProductAmount(model: productModel);

                } : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text("${productModel.amount ?? '1'}",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: ColorsConstants.gray,
                        )),
              ),
              CustomIconButton(
                iconPath: Icons.add,
                onTap: (productModel.amount ?? 0) < (productModel.product?.amount ?? 0)
                    ? () {
                        context.read<CartCubit>().addProductAmount(model: productModel);
                      }
                    : null,
              ),
              const SizedBox(width: 10),
              ElevatedIconButton(
                backGroundColor: ColorsConstants.backGround,
                foreGroundColor: ColorsConstants.gray,
                iconPath: IconsConstants.trashIC,
                title: StringsConstants.remove.tr(),
                onPressed: () {
                  context.read<CartCubit>().deleteItemFromCart(productID: productModel.productId ?? 0);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData iconPath;
  final VoidCallback? onTap;
  final Color? backGroundColor;
  final Color? foreGroundColor;

  const CustomIconButton({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.backGroundColor,
    this.foreGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
        onPressed: onTap,
        icon: Icon(iconPath),
        padding: EdgeInsets.zero,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(45.r, 30.r),
          elevation: 0,
          backgroundColor: backGroundColor ?? ColorsConstants.backGround,
          foregroundColor: foreGroundColor ?? ColorsConstants.gray,
          disabledBackgroundColor: Colors.grey.shade300,
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: foreGroundColor ?? ColorsConstants.gray,
              ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ));
  }
}
