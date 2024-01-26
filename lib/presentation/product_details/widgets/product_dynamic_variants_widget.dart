import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_event.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class ProductDynamicVariantsWidget extends StatefulWidget {
  const ProductDynamicVariantsWidget({
    super.key,
    required this.isAr,
  });

  final bool isAr;

  @override
  State<ProductDynamicVariantsWidget> createState() =>
      _ProductDynamicVariantsWidgetState();
}

class _ProductDynamicVariantsWidgetState
    extends State<ProductDynamicVariantsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
      builder: (context, state) {
        switch (state.productDynamicVariantsState) {
          case RequestStates.loading:
            return Container();

          case RequestStates.success:
            return ((state.dynamicVariantHasNoAmountModel?.length == 0) &&
                    (state.dynamicVariantHasAmountModel?.length == 0))
                ? Container()
                : Column(
                    children: [
                      // ListView.separated(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       return Row(
                      //         children: [
                      //           Text(
                      //               widget.isAr
                      //                   ? state.dynamicVariantHasNoAmountModel![index]
                      //                           .nameAr ??
                      //                       ""
                      //                   : state.dynamicVariantHasNoAmountModel?[index]
                      //                           .nameEn ??
                      //                       "",
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .titleSmall!
                      //                   .copyWith(fontWeight: FontWeight.w600)),
                      //           const Spacer(),
                      //           Text(
                      //               "${state.dynamicVariantHasNoAmountModel?[index].price ?? 0}",
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .bodySmall!
                      //                   .copyWith(fontSize: FontSize.s12.sp)),
                      //           SizedBox(
                      //             width: 46.w,
                      //           ),
                      //           BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
                      //             builder: (context, state1) {
                      //               switch (state1.isSelectedState) {
                      //                 case RequestStates.loading:
                      //                   return GestureDetector(
                      //                     onTap: () {
                      //                       ProductDetailsBloc.get(context)
                      //                           .add(IsSelectedEvent());
                      //
                      //                       if (!ProductDetailsBloc.get(context)
                      //                           .dynamicVariantsList
                      //                           .containsKey(state1
                      //                                   .dynamicVariantHasNoAmountModel?[
                      //                                       index]
                      //                                   .id ??
                      //                               0)) {
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .addAll({
                      //                           (state1
                      //                                   .dynamicVariantHasNoAmountModel?[
                      //                                       index]
                      //                                   .id ??
                      //                               0): {
                      //                             1: (state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0)
                      //                           }
                      //                         });
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                                     .get(context)
                      //                                 .totalPrice +
                      //                             (state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0);
                      //                         setState(() {});
                      //                       } else {
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .remove((state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .id ??
                      //                                 0));
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                                     .get(context)
                      //                                 .totalPrice -
                      //                             (state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0);
                      //                         setState(() {});
                      //                       }
                      //                     },
                      //                     child: Container(
                      //                       width: 24.w,
                      //                       decoration: BoxDecoration(
                      //                           border: Border.all(
                      //                               color: Colors.grey[300]!),
                      //                           borderRadius:
                      //                               BorderRadius.circular(5.r)),
                      //                       height: 24.h,
                      //                       child: ProductDetailsBloc.get(context)
                      //                               .dynamicVariantsList
                      //                               .containsKey(state1
                      //                                       .dynamicVariantHasNoAmountModel?[
                      //                                           index]
                      //                                       .id ??
                      //                                   0)
                      //                           ? Icon(
                      //                               Icons.check,
                      //                               size: 15.r,
                      //                             )
                      //                           : Text(""),
                      //                     ),
                      //                   );
                      //                 case RequestStates.success:
                      //                   return GestureDetector(
                      //                     onTap: () {
                      //                       ProductDetailsBloc.get(context)
                      //                           .add(IsSelectedEvent());
                      //
                      //                       if (!ProductDetailsBloc.get(context)
                      //                           .dynamicVariantsList
                      //                           .containsKey(state1
                      //                                   .dynamicVariantHasNoAmountModel?[
                      //                                       index]
                      //                                   .id ??
                      //                               0)) {
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .addAll({
                      //                           (state1
                      //                                   .dynamicVariantHasNoAmountModel?[
                      //                                       index]
                      //                                   .id ??
                      //                               0): {
                      //                             1: (state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0)
                      //                           }
                      //                         });
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                                     .get(context)
                      //                                 .totalPrice +
                      //                             (state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0);
                      //                         setState(() {});
                      //                       } else {
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .remove((state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .id ??
                      //                                 0));
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                                     .get(context)
                      //                                 .totalPrice -
                      //                             (state1
                      //                                     .dynamicVariantHasNoAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0);
                      //                         setState(() {});
                      //                       }
                      //                     },
                      //                     child: Container(
                      //                       width: 24.w,
                      //                       decoration: BoxDecoration(
                      //                           border: Border.all(
                      //                               color: Colors.grey[300]!),
                      //                           borderRadius:
                      //                               BorderRadius.circular(5.r)),
                      //                       height: 24.h,
                      //                       child: ProductDetailsBloc.get(context)
                      //                               .dynamicVariantsList
                      //                               .containsKey(state1
                      //                                       .dynamicVariantHasNoAmountModel?[
                      //                                           index]
                      //                                       .id ??
                      //                                   0)
                      //                           ? Icon(
                      //                               Icons.check,
                      //                               size: 15.r,
                      //                             )
                      //                           : Text(""),
                      //                     ),
                      //                   );
                      //                 case RequestStates.error:
                      //                   return Container(
                      //                     width: 24.w,
                      //                     decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                             color: Colors.grey[300]!),
                      //                         borderRadius:
                      //                             BorderRadius.circular(5.r)),
                      //                     height: 24.h,
                      //                     child: Icon(
                      //                       Icons.check,
                      //                       size: 15.r,
                      //                     ),
                      //                   );
                      //               }
                      //             },
                      //           )
                      //         ],
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) => Column(
                      //           children: [
                      //             SizedBox(
                      //               height: 30.h,
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //               height: 1.h,
                      //               color: ColorsConstants.lightBlue,
                      //             ),
                      //             SizedBox(
                      //               height: 22.h,
                      //             ),
                      //           ],
                      //         ),
                      //     itemCount:
                      //         state.dynamicVariantHasNoAmountModel?.length ?? 0),
                      // SizedBox(
                      //   height: 52.h,
                      // ),
                      // ListView.separated(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       return Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           SizedBox(
                      //             width: 150.w,
                      //             child: Text(
                      //                 widget.isAr
                      //                     ? state.dynamicVariantHasAmountModel![index]
                      //                             .nameAr ??
                      //                         ""
                      //                     : state.dynamicVariantHasAmountModel?[index]
                      //                             .nameEn ??
                      //                         "",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .titleSmall!
                      //                     .copyWith(fontWeight: FontWeight.w600)),
                      //           ),
                      //           Text(
                      //               "${state.dynamicVariantHasAmountModel?[index].price ?? 0}",
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .bodySmall!
                      //                   .copyWith(fontSize: FontSize.s12.sp)),
                      //           SizedBox(
                      //             width: 100.w,
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 GestureDetector(
                      //                     onTap: () {
                      //                       if (ProductDetailsBloc.get(context)
                      //                           .dynamicVariantsList
                      //                           .containsKey(state
                      //                               .dynamicVariantHasAmountModel?[
                      //                                   index]
                      //                               .id)) {
                      //                         ProductDetailsBloc.get(context)
                      //                             .counterList[index]++;
                      //
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .update(
                      //                               state
                      //                                       .dynamicVariantHasAmountModel?[
                      //                                           index]
                      //                                       .id ??
                      //                                   0,
                      //                               (value) => {
                      //                                 ProductDetailsBloc.get(context)
                      //                                     .counterList[index]: state
                      //                                         .dynamicVariantHasAmountModel?[
                      //                                             index]
                      //                                         .price ??
                      //                                     0
                      //                               },
                      //                             );
                      //
                      //                         // ProductDetailsBloc.get(context)
                      //                         //     .totalPrice = ProductDetailsBloc
                      //                         //             .get(context)
                      //                         //         .totalPrice +
                      //                         //     (ProductDetailsBloc.get(context)
                      //                         //             .counterList[index] *
                      //                         //         (state
                      //                         //                 .dynamicVariantHasAmountModel?[
                      //                         //                     index]
                      //                         //                 .price ??
                      //                         //             0));
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                             .get(context)
                      //                             .totalPrice +
                      //                             (state
                      //                                 .dynamicVariantHasAmountModel?[
                      //                             index]
                      //                                 .price ??
                      //                                 0);
                      //                         setState(() {
                      //                           ProductDetailsBloc.get(context).add(AddToCounterListEvent(index: index));
                      //
                      //                         });
                      //                       } else {
                      //                         ProductDetailsBloc.get(context)
                      //                             .counterList[index]++;
                      //
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .addAll(
                      //                           {
                      //                             (state
                      //                                     .dynamicVariantHasAmountModel?[
                      //                                         index]
                      //                                     .id ??
                      //                                 0): {
                      //                               (1): (state
                      //                                       .dynamicVariantHasAmountModel?[
                      //                                           index]
                      //                                       .price ??
                      //                                   0)
                      //                             },
                      //                           },
                      //                         );
                      //
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                                     .get(context)
                      //                                 .totalPrice +
                      //                             (state
                      //                                     .dynamicVariantHasAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0);
                      //
                      //                         setState(() {
                      //                           ProductDetailsBloc.get(context).add(AddToCounterListEvent(index: index));
                      //
                      //                         });
                      //                       }
                      //
                      //                     },
                      //                     child:
                      //                         SvgPicture.asset(IconsConstants.addIC)),
                      //                 Text(
                      //                     "${ProductDetailsBloc.get(context).counterList[index]}",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .titleSmall!
                      //                         .copyWith(fontWeight: FontWeight.w600)),
                      //                 GestureDetector(
                      //                     onTap: () {
                      //                       if (ProductDetailsBloc.get(context)
                      //                               .counterList[index] ==
                      //                           1) {
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .remove(state
                      //                                     .dynamicVariantHasAmountModel?[
                      //                                         index]
                      //                                     .id ??
                      //                                 0);
                      //
                      //                         ProductDetailsBloc.get(context)
                      //                             .counterList[index]--;
                      //
                      //
                      //
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                                     .get(context)
                      //                                 .totalPrice -
                      //                             (state
                      //                                     .dynamicVariantHasAmountModel?[
                      //                                         index]
                      //                                     .price ??
                      //                                 0);
                      //                         setState(() {
                      //                           ProductDetailsBloc.get(context).add(RemoveFromCounterListEvent(index: index));
                      //
                      //                         });
                      //                       } else if (ProductDetailsBloc.get(context)
                      //                               .counterList[index] ==
                      //                           0) {
                      //                         setState(() {
                      //                           ProductDetailsBloc.get(context).add(RemoveFromCounterListEvent(index: index));
                      //
                      //                         });
                      //                       } else {
                      //                         ProductDetailsBloc.get(context)
                      //                             .counterList[index]--;
                      //
                      //                         // ProductDetailsBloc.get(context)
                      //                         //     .totalPrice = ProductDetailsBloc
                      //                         //             .get(context)
                      //                         //         .totalPrice -
                      //                         //     (ProductDetailsBloc.get(context)
                      //                         //             .counterList[index] *
                      //                         //         (state
                      //                         //                 .dynamicVariantHasAmountModel?[
                      //                         //                     index]
                      //                         //                 .price ??
                      //                         //             0));
                      //                         ProductDetailsBloc.get(context)
                      //                             .totalPrice = ProductDetailsBloc
                      //                             .get(context)
                      //                             .totalPrice -
                      //                             (state
                      //                                 .dynamicVariantHasAmountModel?[
                      //                             index]
                      //                                 .price ??
                      //                                 0);
                      //                         ProductDetailsBloc.get(context)
                      //                             .dynamicVariantsList
                      //                             .update(
                      //                                 state
                      //                                         .dynamicVariantHasAmountModel?[
                      //                                             index]
                      //                                         .id ??
                      //                                     0,
                      //                                 (value) => {
                      //                                       ProductDetailsBloc.get(
                      //                                                   context)
                      //                                               .counterList[
                      //                                           index]: state
                      //                                               .dynamicVariantHasAmountModel?[
                      //                                                   index]
                      //                                               .price ??
                      //                                           0
                      //                                     });
                      //
                      //                         setState(() {
                      //                           ProductDetailsBloc.get(context).add(RemoveFromCounterListEvent(index: index));
                      //
                      //                         });
                      //                       }
                      //                     },
                      //                     child: SvgPicture.asset(
                      //                         IconsConstants.minusIC)),
                      //               ],
                      //             ),
                      //           )
                      //         ],
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) => Column(
                      //           children: [
                      //             SizedBox(
                      //               height: 30.h,
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //               height: 1.h,
                      //               color: ColorsConstants.lightBlue,
                      //             ),
                      //             SizedBox(
                      //               height: 22.h,
                      //             ),
                      //           ],
                      //         ),
                      //     itemCount: state.dynamicVariantHasAmountModel?.length ?? 0),

                      Container(),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                      widget.isAr
                                          ? state
                                                  .dynamicVariantHasNoAmountModel![
                                                      index]
                                                  .nameAr ??
                                              ""
                                          : state
                                                  .dynamicVariantHasNoAmountModel?[
                                                      index]
                                                  .nameEn ??
                                              "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600)),
                                ),
                                const Spacer(),
                                Text(
                                    "${state.dynamicVariantHasNoAmountModel?[index].price ?? 0}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: FontSize.s12.sp)),
                                SizedBox(
                                  width: 46.w,
                                ),
                                BlocBuilder<ProductDetailsBloc,
                                    ProductDetailsStates>(
                                  builder: (context, state1) {
                                    switch (state1.isSelectedState) {
                                      case RequestStates.loading:
                                        return GestureDetector(
                                          onTap: () {
                                            if (!ProductDetailsBloc.get(context)
                                                .dynamicVariantsList
                                                .containsKey(state1
                                                        .dynamicVariantHasNoAmountModel?[
                                                            index]
                                                        .id ??
                                                    0)) {
                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .addAll({
                                                (state1
                                                        .dynamicVariantHasNoAmountModel?[
                                                            index]
                                                        .id ??
                                                    0): {
                                                  1: (state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .price ??
                                                      0)
                                                }
                                              });
                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice +
                                                  (state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              ProductDetailsBloc.get(context)
                                                  .add(IsSelectedEvent(
                                                      totalPrice: state1
                                                              .totalPrice ??
                                                          0 +
                                                              (state1
                                                                      .dynamicVariantHasNoAmountModel?[
                                                                          index]
                                                                      .price ??
                                                                  0)));
                                              setState(() {});
                                            } else {
                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .remove((state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .id ??
                                                      0));
                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice -
                                                  (state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              ProductDetailsBloc.get(context)
                                                  .add(IsSelectedEvent(
                                                      totalPrice: state1
                                                              .totalPrice ??
                                                          0 -
                                                              (state1
                                                                      .dynamicVariantHasNoAmountModel?[
                                                                          index]
                                                                      .price ??
                                                                  0)));
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey[300]!),
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                            height: 24.h,
                                            child: ProductDetailsBloc.get(
                                                        context)
                                                    .dynamicVariantsList
                                                    .containsKey(state1
                                                            .dynamicVariantHasNoAmountModel?[
                                                                index]
                                                            .id ??
                                                        0)
                                                ? Icon(
                                                    Icons.check,
                                                    size: 15.r,
                                                  )
                                                : Text(""),
                                          ),
                                        );
                                      case RequestStates.success:
                                        return GestureDetector(
                                          onTap: () {
                                            if (!ProductDetailsBloc.get(context)
                                                .dynamicVariantsList
                                                .containsKey(state1
                                                        .dynamicVariantHasNoAmountModel?[
                                                            index]
                                                        .id ??
                                                    0)) {
                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .addAll({
                                                (state1
                                                        .dynamicVariantHasNoAmountModel?[
                                                            index]
                                                        .id ??
                                                    0): {
                                                  1: (state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .price ??
                                                      0)
                                                }
                                              });
                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice +
                                                  (state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              ProductDetailsBloc.get(context)
                                                  .add(IsSelectedEvent(
                                                      totalPrice: state1
                                                              .totalPrice ??
                                                          0 +
                                                              (state1
                                                                      .dynamicVariantHasNoAmountModel?[
                                                                          index]
                                                                      .price ??
                                                                  0)));
                                              setState(() {});
                                            } else {
                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .remove((state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .id ??
                                                      0));
                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice -
                                                  (state1
                                                          .dynamicVariantHasNoAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              ProductDetailsBloc.get(context)
                                                  .add(IsSelectedEvent(
                                                      totalPrice: state1
                                                              .totalPrice ??
                                                          0 -
                                                              (state1
                                                                      .dynamicVariantHasNoAmountModel?[
                                                                          index]
                                                                      .price ??
                                                                  0)));
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey[300]!),
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                            height: 24.h,
                                            child: ProductDetailsBloc.get(
                                                        context)
                                                    .dynamicVariantsList
                                                    .containsKey(state1
                                                            .dynamicVariantHasNoAmountModel?[
                                                                index]
                                                            .id ??
                                                        0)
                                                ? Icon(
                                                    Icons.check,
                                                    size: 15.r,
                                                  )
                                                : Text(""),
                                          ),
                                        );
                                      case RequestStates.error:
                                        return Container(
                                          width: 24.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[300]!),
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          height: 24.h,
                                          child: Icon(
                                            Icons.check,
                                            size: 15.r,
                                          ),
                                        );
                                    }
                                  },
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => Column(
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    height: 1.h,
                                    color: ColorsConstants.lightBlue,
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                ],
                              ),
                          itemCount:
                              state.dynamicVariantHasNoAmountModel?.length ??
                                  0),
                      SizedBox(
                        height: 52.h,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: Text(
                                      widget.isAr
                                          ? state
                                                  .dynamicVariantHasAmountModel![
                                                      index]
                                                  .nameAr ??
                                              ""
                                          : state
                                                  .dynamicVariantHasAmountModel?[
                                                      index]
                                                  .nameEn ??
                                              "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                    "${state.dynamicVariantHasAmountModel?[index].price ?? 0}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: FontSize.s12.sp)),
                                SizedBox(
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            if (ProductDetailsBloc.get(context)
                                                .dynamicVariantsList
                                                .containsKey(state
                                                    .dynamicVariantHasAmountModel?[
                                                        index]
                                                    .id)) {
                                              ProductDetailsBloc.get(context)
                                                  .counterList[index]++;

                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .update(
                                                    state
                                                            .dynamicVariantHasAmountModel?[
                                                                index]
                                                            .id ??
                                                        0,
                                                    (value) => {
                                                      ProductDetailsBloc.get(
                                                                  context)
                                                              .counterList[
                                                          index]: state
                                                              .dynamicVariantHasAmountModel?[
                                                                  index]
                                                              .price ??
                                                          0
                                                    },
                                                  );

                                              // ProductDetailsBloc.get(context)
                                              //     .totalPrice = ProductDetailsBloc
                                              //             .get(context)
                                              //         .totalPrice +
                                              //     (ProductDetailsBloc.get(context)
                                              //             .counterList[index] *
                                              //         (state
                                              //                 .dynamicVariantHasAmountModel?[
                                              //                     index]
                                              //                 .price ??
                                              //             0));
                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice +
                                                  (state
                                                          .dynamicVariantHasAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              setState(() {
                                                ProductDetailsBloc.get(context)
                                                    .add(AddToCounterListEvent(
                                                        index: index,
                                                        totalPrice: state
                                                                .totalPrice ??
                                                            0 +
                                                                (state
                                                                        .dynamicVariantHasAmountModel?[
                                                                            index]
                                                                        .price ??
                                                                    0)));
                                              });
                                            } else {
                                              ProductDetailsBloc.get(context)
                                                  .counterList[index]++;

                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .addAll(
                                                {
                                                  (state
                                                          .dynamicVariantHasAmountModel?[
                                                              index]
                                                          .id ??
                                                      0): {
                                                    (1): (state
                                                            .dynamicVariantHasAmountModel?[
                                                                index]
                                                            .price ??
                                                        0)
                                                  },
                                                },
                                              );

                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice +
                                                  (state
                                                          .dynamicVariantHasAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);

                                              setState(() {
                                                ProductDetailsBloc.get(context)
                                                    .add(AddToCounterListEvent(
                                                        index: index,
                                                        totalPrice: state
                                                                .totalPrice ??
                                                            0 +
                                                                (state
                                                                        .dynamicVariantHasAmountModel?[
                                                                            index]
                                                                        .price ??
                                                                    0)));
                                              });
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              IconsConstants.addIC,
                                              colorFilter: ColorFilter.mode(
                                                  ColorsConstants.iconsColor,
                                                  BlendMode.srcIn))),
                                      Text(
                                          "${ProductDetailsBloc.get(context).counterList[index]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      GestureDetector(
                                          onTap: () {
                                            if (ProductDetailsBloc.get(context)
                                                    .counterList[index] ==
                                                1) {
                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .remove(state
                                                          .dynamicVariantHasAmountModel?[
                                                              index]
                                                          .id ??
                                                      0);

                                              ProductDetailsBloc.get(context)
                                                  .counterList[index]--;

                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice -
                                                  (state
                                                          .dynamicVariantHasAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              setState(() {
                                                ProductDetailsBloc.get(context).add(
                                                    RemoveFromCounterListEvent(
                                                        index: index,
                                                        totalPrice: state
                                                                .totalPrice ??
                                                            0 -
                                                                (state
                                                                        .dynamicVariantHasAmountModel?[
                                                                            index]
                                                                        .price ??
                                                                    0)));
                                              });
                                            } else if (ProductDetailsBloc.get(
                                                        context)
                                                    .counterList[index] ==
                                                0) {
                                              setState(() {
                                                ProductDetailsBloc.get(context).add(
                                                    RemoveFromCounterListEvent(
                                                        index: index,
                                                        totalPrice: state
                                                                .totalPrice ??
                                                            0 -
                                                                (state
                                                                        .dynamicVariantHasAmountModel?[
                                                                            index]
                                                                        .price ??
                                                                    0)));
                                              });
                                            } else {
                                              ProductDetailsBloc.get(context)
                                                  .counterList[index]--;

                                              // ProductDetailsBloc.get(context)
                                              //     .totalPrice = ProductDetailsBloc
                                              //             .get(context)
                                              //         .totalPrice -
                                              //     (ProductDetailsBloc.get(context)
                                              //             .counterList[index] *
                                              //         (state
                                              //                 .dynamicVariantHasAmountModel?[
                                              //                     index]
                                              //                 .price ??
                                              //             0));
                                              ProductDetailsBloc.get(context)
                                                  .totalPrice = ProductDetailsBloc
                                                          .get(context)
                                                      .totalPrice -
                                                  (state
                                                          .dynamicVariantHasAmountModel?[
                                                              index]
                                                          .price ??
                                                      0);
                                              ProductDetailsBloc.get(context)
                                                  .dynamicVariantsList
                                                  .update(
                                                      state
                                                              .dynamicVariantHasAmountModel?[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      (value) => {
                                                            ProductDetailsBloc.get(
                                                                        context)
                                                                    .counterList[
                                                                index]: state
                                                                    .dynamicVariantHasAmountModel?[
                                                                        index]
                                                                    .price ??
                                                                0
                                                          });

                                              setState(() {
                                                ProductDetailsBloc.get(context).add(
                                                    RemoveFromCounterListEvent(
                                                        index: index,
                                                        totalPrice: state
                                                                .totalPrice ??
                                                            0 -
                                                                (state
                                                                        .dynamicVariantHasAmountModel?[
                                                                            index]
                                                                        .price ??
                                                                    0)));
                                              });
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              IconsConstants.minusIC,
                                              colorFilter: ColorFilter.mode(
                                                  ColorsConstants.iconsColor,
                                                  BlendMode.srcIn))),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => Column(
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    height: 1.h,
                                    color: ColorsConstants.lightBlue,
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                ],
                              ),
                          itemCount:
                              state.dynamicVariantHasAmountModel?.length ?? 0),
                      SizedBox(
                        height: 37.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 1.h,
                        color: ColorsConstants.lightBlue,
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                    ],
                  );

          case RequestStates.error:
            return Container();
        }
      },
    );
  }
}
