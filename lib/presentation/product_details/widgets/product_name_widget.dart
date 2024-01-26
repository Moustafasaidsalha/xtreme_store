import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_event.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import '../../orders/pages/orders.dart';

class ProductNameWidget extends StatelessWidget {
  const ProductNameWidget({
    super.key,
    required this.isAr,
  });

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
      // buildWhen: (previous, current) =>
      //     previous is GetProductDetailsSuccessState,
      builder: (context, state) {
        switch (state.productDetailsState) {
          case RequestStates.loading:
            return const ShimmerLoader();

          case RequestStates.success:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    isAr
                        ? state.productDataModel?.productModel?.nameAr ?? ""
                        : state.productDataModel?.productModel?.nameEn ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: FontSize.s14, letterSpacing: .14),
                  ),
                ),
                ShippingStatusWidget(
                    onTap: () {
                      if (state.productDataModel?.productModel?.amount == 0) {
                        ProductDetailsBloc.get(context).add(NotifyMeEvent(
                            productId:
                                state.productDataModel?.productModel?.id ?? 0,
                            context: context));
                      }
                    },
                    backGroundColor: ColorsConstants.lightBlue,
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorsConstants.black, fontSize: FontSize.s11),
                    title: (state.productDataModel?.productModel?.amount == 0)
                        ? StringsConstants.notifyMe.tr()
                        : StringsConstants.availableInStock.tr())
              ],
            );

          case RequestStates.error:
            return Container();
        }
      },
    );
  }
}
