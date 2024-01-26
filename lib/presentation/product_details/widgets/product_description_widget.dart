import 'package:config/config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';


class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({
    super.key,
    required this.isAr,
  });

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(

      builder: (context, state) {
        switch (state.productDetailsState) {
          case RequestStates.loading:
            return  Container();

          case RequestStates.success:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringsConstants.description.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 15.h,
                ),
                isGCCApp? Column(
                  children: [
                    Text(
                       "${StringsConstants.weight.tr()} : ${state.productDataModel?.productModel?.weight??0}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: FontSize.s11.sp)),
                    SizedBox(height: 5.h,)
                  ],
                ):Container(),
                Text(
                    isAr
                        ? state.productDataModel?.productModel
                        ?.descriptionAr ??
                        ""
                        : state.productDataModel?.productModel
                        ?.descriptionEn ??
                        "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: FontSize.s11.sp)),
              ],
            );

          case RequestStates.error:
            return Container();
        }
      },
    );
  }
}
