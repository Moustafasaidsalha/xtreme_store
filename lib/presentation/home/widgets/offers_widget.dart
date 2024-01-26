import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/home/widgets/card_title_widget.dart';

import '../../../data/models/product.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({
    required this.offersProductsModel,
    super.key,
  });
  final ProductsModel? offersProductsModel;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Column(
      children: [
        CardTitleWidget(
          text: StringsConstants.offers.tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(RoutesConstant.offers);
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
                      // ProductDetailsBloc.get(context)..getProductDetails(offersProductsModel?.productMetaModel?.products?[index].id??0).then((value) async{
                      //   ProductDetailsBloc.get(context).getDynamicVariants(offersProductsModel?.productMetaModel?.products?[index].id??0).then((value) => Navigator.of(context).pushNamed(
                      //       RoutesConstant.productDetails));
                      //    ProductDetailsBloc.get(context)..add(GetProductDetailsEvent())..add(GetProductsDynamicVariantsEvent());
                      //   Navigator.pushNamed(context,  RoutesConstant.productDetails);
                      // Navigator.of(context).pushNamed(
                      // RoutesConstant.productDetails,arguments: offersProductsModel?.productMetaModel?.products?[index].id??0);
                      Navigator.of(context).pushNamed(
                        RoutesConstant.productDetails,
                        arguments: [
                          offersProductsModel?.productMetaModel?.products?[index].id ?? 0,
                          offersProductsModel?.productMetaModel?.products?[index].categoryId ?? 0
                        ],
                      );
                    },
                    child: CardItemWidget(
                      addToCart: () {
                        Navigator.of(context).pushNamed(
                          RoutesConstant.productDetails,
                          arguments: [
                            offersProductsModel?.productMetaModel?.products?[index].id ?? 0,
                            offersProductsModel?.productMetaModel?.products?[index].categoryId ?? 0
                          ],
                        );
                        // context.read<HomeBloc>().addProductToCart(
                        //       productModel: offersProductsModel!.productMetaModel!.products![index],
                        //     );
                      },
                      productImage:
                          offersProductsModel?.productMetaModel?.products?[index].images?[0].url ??
                              "",
                      productName: isAr
                          ? offersProductsModel?.productMetaModel?.products![index].nameAr ?? ""
                          : offersProductsModel?.productMetaModel?.products?[index].nameEn ?? "",
                      productPrice:
                          offersProductsModel?.productMetaModel?.products?[index].price ?? 0,
                      productOfferPrice:
                          offersProductsModel?.productMetaModel?.products?[index].offerPrice ?? 0,

                      isOffer: true,
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 9,
                  ),
              itemCount: offersProductsModel?.productMetaModel?.products?.length ?? 0),
        ),
      ],
    );
  }
}
