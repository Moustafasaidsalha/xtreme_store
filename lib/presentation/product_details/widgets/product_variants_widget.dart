import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/product_details/widgets/variants_widget.dart';

import '../../../app/constants/colors_constants.dart';

class ProductVariantsWidget extends StatelessWidget {
  const ProductVariantsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
      builder: (context, state) {
        switch (state.productDetailsState) {
          case RequestStates.loading:
            return Container();

          case RequestStates.success:
            return (state.productDataModel?.productModel?.variants?.length != 0)
                ? Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => VariantsWidget(
                              currentVariantId:
                                  state.productDataModel?.variant?[index].id ??
                                      0,
                              variant: state.productDataModel?.variant ?? [],
                              productCode:
                                  state.productDataModel?.productModel?.code ??
                                      "",
                              variants: state.productDataModel?.productModel?.variants ??
                                  [],
                              variantNameAr:
                                  state.productDataModel?.variant?[index].nameAr ??
                                      "",
                              variantNameEn:
                                  state.productDataModel?.variant?[index].nameEn ??
                                      "",
                              variantValues: state.productDataModel
                                      ?.variant?[index].variantValues ??
                                  []),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 24.h,
                              ),
                          itemCount: state.productDataModel?.variant?.length ?? 0),
                      SizedBox(
                        height: 37.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 1.h,
                        color: ColorsConstants.lightBlue,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                    ],
                  )
                : Container();

          case RequestStates.error:
            return Container();
        }
      },
    );
  }
}
