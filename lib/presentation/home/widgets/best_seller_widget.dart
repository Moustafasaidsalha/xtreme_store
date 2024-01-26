import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/home/widgets/card_title_widget.dart';


class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({
    required this.bestSellerProductsModel,
    super.key,
  });
  final ProductsModel? bestSellerProductsModel;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Column(
      children: [
        CardTitleWidget(
          text: StringsConstants.bestSeller.tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(RoutesConstant.bestSeller);
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
                  // ProductDetailsBloc.get(context)..getProductDetails(bestSellerProductsModel?.productMetaModel?.products?[index].id??0)..getDynamicVariants(bestSellerProductsModel?.productMetaModel?.products?[index].id??0).then((value) =>    Navigator.of(context).pushNamed(
                  //    RoutesConstant.productDetails));
                  // Navigator.of(context).pushNamed(
                  //     RoutesConstant.productDetails,arguments: bestSellerProductsModel?.productMetaModel?.products?[index].id??0);
                  Navigator.of(context).pushNamed(
                    RoutesConstant.productDetails,
                    arguments: [
                      bestSellerProductsModel?.productMetaModel?.products?[index].id ?? 0,
                      bestSellerProductsModel?.productMetaModel?.products?[index].categoryId ?? 0
                    ],
                  );
                },
                child: CardItemWidget(
                    addToCart: () {
                      Navigator.of(context).pushNamed(
                        RoutesConstant.productDetails,
                        arguments: [
                          bestSellerProductsModel?.productMetaModel?.products?[index].id ?? 0,
                          bestSellerProductsModel?.productMetaModel?.products?[index].categoryId ?? 0
                        ],
                      );
                      // context.read<HomeBloc>().addProductToCart(
                      //   productModel: bestSellerProductsModel!.productMetaModel!.products![index],
                      // );
                    },
                    productImage: bestSellerProductsModel
                            ?.productMetaModel?.products?[index].images?[0].url ??
                        "",
                    productName: isAr
                        ? bestSellerProductsModel?.productMetaModel?.products![index].nameAr ?? ""
                        : bestSellerProductsModel?.productMetaModel?.products?[index].nameEn ?? "",
                    productPrice:
                        bestSellerProductsModel?.productMetaModel?.products?[index].price ?? 0),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 9,
              ),
              itemCount: bestSellerProductsModel?.productMetaModel?.products?.length ?? 0,
            )),
      ],
    );
  }
}
