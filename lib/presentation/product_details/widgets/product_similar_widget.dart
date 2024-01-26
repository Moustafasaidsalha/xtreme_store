import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

import '../../common_widgets/cart_item/cart_item_widget.dart';

class ProductSimilarWidget extends StatelessWidget {
  const ProductSimilarWidget({
    super.key,
    required this.isAr,
  });

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringsConstants.similarProducts.tr(),
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w600)),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          height: 239.h,
          child: BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
            // buildWhen: (previous, current) =>
            //     current is GetProductsSuccessState,
            builder: (context, state) {
              switch(state.similarProductsState){
                case RequestStates.loading:
                  // return ((state.similarProducts==null)||(state.similarProducts?.length==0))? Container(): ShimmerLoader();
                  return Container();

                case RequestStates.success:
                  return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RoutesConstant.productDetails,
                            arguments: [
                              state.similarProducts?[index].id ?? 0,
                              state.similarProducts?[index].categoryId ?? 0
                            ],
                          );
                        },
                        child: CardItemWidget(

                          addToCart: () {
                            Navigator.of(context).pushNamed(
                              RoutesConstant.productDetails,
                              arguments: [
                                state.similarProducts?[index].id ?? 0,
                                state.similarProducts?[index].categoryId ?? 0
                              ],
                            );
                          },
                          productImage: state

                              .similarProducts![index]
                              .images![0]
                              .url!,
                          productName: isAr?state
                              .similarProducts![index]
                              .nameAr!:state
                              .similarProducts![index]
                              .nameEn!,
                          productPrice: state
                              .similarProducts![index]
                              .price!,
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        width: 9,
                      ),
                      itemCount: state.similarProducts?.length??0);
                case RequestStates.error:
                  return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
