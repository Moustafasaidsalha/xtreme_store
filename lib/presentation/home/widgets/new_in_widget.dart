import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/home/widgets/card_title_widget.dart';


class NewSellerWidget extends StatelessWidget {
  const NewSellerWidget({
    required this.newInProductsModel,
    super.key,
  });
  final ProductsModel? newInProductsModel;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Column(
      children: [
        CardTitleWidget(
          text: StringsConstants.newIn.tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(RoutesConstant.newIn);
          },
        ),
        SizedBox(
          height: 11.h,
        ),
        SizedBox(
            height: 239.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      // ProductDetailsBloc.get(context)..getProductDetails(newInProductsModel?.productMetaModel?.products?[index].id??0)..getDynamicVariants(newInProductsModel?.productMetaModel?.products?[index].id??0).then((value) =>    Navigator.of(context).pushNamed(
                      //    RoutesConstant.productDetails));
                      // Navigator.of(context).pushNamed(
                      //     RoutesConstant.productDetails,arguments:newInProductsModel?.productMetaModel?.products?[index].id??0);
                      Navigator.of(context).pushNamed(
                        RoutesConstant.productDetails,
                        arguments: [
                          newInProductsModel?.productMetaModel?.products?[index].id ?? 0,
                          newInProductsModel?.productMetaModel?.products?[index].categoryId ?? 0
                        ],
                      );
                    },
                    child: CardItemWidget(
                      addToCart: () {
                        Navigator.of(context).pushNamed(
                          RoutesConstant.productDetails,
                          arguments: [
                            newInProductsModel?.productMetaModel?.products?[index].id ?? 0,
                            newInProductsModel?.productMetaModel?.products?[index].categoryId ?? 0
                          ],
                        );
                        // context.read<HomeBloc>().addProductToCart(
                        //   productModel: newInProductsModel!.productMetaModel!.products![index],
                        // );
                      },
                        productImage:
                            newInProductsModel!.productMetaModel!.products![index].images![0].url!,
                        productName: isAr
                            ? newInProductsModel!.productMetaModel!.products![index].nameAr!
                            : newInProductsModel!.productMetaModel!.products![index].nameEn!,
                        productPrice:
                            newInProductsModel!.productMetaModel!.products![index].price!)),
                separatorBuilder: (context, index) => SizedBox(
                      width: 9.w,
                    ),
                itemCount: newInProductsModel?.productMetaModel?.products?.length ?? 0)),
      ],
    );
  }
}
