import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/category/model_view/category_cubit/category_cubit.dart';
import 'package:extreme_store/presentation/category/model_view/category_cubit/category_states.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/home/widgets/best_seller_widget.dart';
import 'package:extreme_store/presentation/home/widgets/new_in_widget.dart';
import 'package:extreme_store/presentation/home/widgets/offers_widget.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(
      {super.key, this.categoryId, this.subCategoryId, this.brandId});
  final int? categoryId;
  final int? subCategoryId;
  final int? brandId;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    CategoryCubit.get(context)
      ..getNewInProducts(
          widget.categoryId, widget.subCategoryId, widget.brandId)
      ..getBestSellerProducts(
          widget.categoryId, widget.subCategoryId, widget.brandId)
      ..getOffersProducts(
          widget.categoryId, widget.subCategoryId, widget.brandId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithActionButton(title: " "),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 13.h, bottom: 24.h, left: 15.w, right: 16.w),
          child: Column(
            children: [
              // Row(children: [
              //   Container(
              //     height: 40.h,
              //     width: 303.w,
              //     color: Colors.grey[100],
              //     child: TextFormField(
              //
              //       decoration: InputDecoration(
              //
              //           prefixIcon: Container(
              //               padding: const EdgeInsets.symmetric(vertical: 8),
              //               child: SvgPicture.asset(IconsConstants.searchIC)),
              //
              //           border: OutlineInputBorder(
              //
              //               borderRadius: BorderRadius.circular(8))),
              //     ),
              //   ),
              //   SizedBox(width: 16.w,),
              //   Container(
              //       height: 40.h,
              //       width: 39.w,
              //       color: Colors.grey[100],
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: SvgPicture.asset(IconsConstants.searchPrefIC),
              //       ))
              // ],),
              SizedBox(
                height: AppSize.s24.h,
              ),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         const Text(StringsConstants.bestSeller),
              //         const Spacer(),
              //         TextButton(
              //           onPressed: () {},
              //           style: TextButton.styleFrom(
              //               padding: EdgeInsets.zero
              //           ),
              //           child: Row(
              //             children: [
              //               const Text(StringsConstants.viewAll),
              //               SizedBox(width: 5.w,),
              //               SvgPicture.asset(IconsConstants.arrowRightIC)
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       height: 11.h,
              //     ),
              //     Container(
              //       height: 239.h,
              //       child: ListView.separated(
              //           shrinkWrap: true,
              //           scrollDirection: Axis.horizontal,
              //           itemBuilder: (context, index) => CardItem(),
              //           separatorBuilder: (context, index) => const SizedBox(
              //             width: 9,
              //           ),
              //           itemCount: 10),
              //     ),
              //   ],),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         const Text(StringsConstants.newIn),
              //         const Spacer(),
              //         TextButton(
              //           style: TextButton.styleFrom(
              //               padding: EdgeInsets.zero
              //           ),
              //           onPressed: () {},
              //           child: Row(
              //             children: [
              //               const Text(StringsConstants.viewAll),
              //               SizedBox(width: 5.w,),
              //               SvgPicture.asset(IconsConstants.arrowRightBarIC)
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       height: 11.h,
              //     ),
              //     Container(
              //       height: 239.h,
              //       child: ListView.separated(
              //           shrinkWrap: true,
              //           scrollDirection: Axis.horizontal,
              //           itemBuilder: (context, index) => CardItem(),
              //           separatorBuilder: (context, index) => const SizedBox(
              //             width: 9,
              //           ),
              //           itemCount: 10),
              //     ),
              //
              //   ],
              // ),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         const Text(StringsConstants.offers),
              //         const Spacer(),
              //         TextButton(
              //
              //           style: TextButton.styleFrom(
              //
              //             padding: EdgeInsets.zero,
              //
              //           ),
              //
              //           onPressed: () {},
              //           child: Row(
              //             children: [
              //               const Text(StringsConstants.viewAll),
              //               SizedBox(width: 5.w,),
              //               SvgPicture.asset(IconsConstants.arrowRightIC)
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       height: 11.h,
              //     ),
              //     Container(
              //       height: 239.h,
              //       child: ListView.separated(
              //           shrinkWrap: true,
              //           scrollDirection: Axis.horizontal,
              //           itemBuilder: (context, index) => CardItem(),
              //           separatorBuilder: (context, index) => const SizedBox(
              //             width: 9,
              //           ),
              //           itemCount: 10),
              //     ),
              //
              //   ],
              // )
              BlocBuilder<CategoryCubit, CategoryStates>(
                  builder: (context, state) {
                switch (state.getBestSellerState) {
                  case RequestStates.loading:
                    return const ShimmerLoader();

                  case RequestStates.success:
                    return state.bestSellerProductsModel?.productMetaModel
                                ?.totalLength ==
                            0
                        ? Container(
                            child: NoProductsInCategoryWidget(
                              title: StringsConstants.noProductsBestSeller.tr(),
                            ),
                          )
                        : BestSellerWidget(
                            bestSellerProductsModel:
                                state.bestSellerProductsModel);
                  case RequestStates.error:
                    return Container(
                      child: SvgPicture.asset(IconsConstants.placeholder),
                    );
                }
              }),

              SizedBox(
                height: AppSize.s24.h,
              ),
              BlocBuilder<CategoryCubit, CategoryStates>(
                  builder: (context, state) {
                switch (state.getBestSellerState) {
                  case RequestStates.loading:
                    return const ShimmerLoader();

                  case RequestStates.success:
                    return state.newInProductsModel?.productMetaModel
                                ?.totalLength ==
                            0
                        ? Container(
                            child: NoProductsInCategoryWidget(
                              title: StringsConstants.noProductsNewIn.tr(),
                            ),
                          )
                        : NewSellerWidget(
                            newInProductsModel: state.newInProductsModel);
                  case RequestStates.error:
                    return Container(
                      child: SvgPicture.asset(IconsConstants.placeholder),
                    );
                }
              }),

              SizedBox(
                height: AppSize.s24.h,
              ),
              BlocBuilder<CategoryCubit, CategoryStates>(
                  builder: (context, state) {
                switch (state.getBestSellerState) {
                  case RequestStates.loading:
                    return const ShimmerLoader();

                  case RequestStates.success:
                    return state.offersProductsModel?.productMetaModel
                                ?.totalLength ==
                            0
                        ? Container(
                            child: NoProductsInCategoryWidget(
                              title: StringsConstants.noProductsOffer.tr(),
                            ),
                          )
                        : OffersWidget(
                            offersProductsModel: state.offersProductsModel);
                  case RequestStates.error:
                    return Container(
                      child: SvgPicture.asset(IconsConstants.placeholder),
                    );
                }
              }),

              SizedBox(
                height: AppSize.s24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoProductsInCategoryWidget extends StatelessWidget {
  const NoProductsInCategoryWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: Theme.of(context).iconTheme.color ??
                  Theme.of(context).primaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.shopping_cart,
              size: 80,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: FontSize.s24.sp),
            ),
          ],
        ),
      ),
    );
  }
}
