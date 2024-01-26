import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_event.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_cubit.dart';

import '../widgets/product_bottom_sheet.dart';
import '../widgets/product_description_widget.dart';
import '../widgets/product_dynamic_variants_widget.dart';
import '../widgets/product_name_widget.dart';
import '../widgets/product_similar_widget.dart';
import '../widgets/product_top_section_widget.dart';
import '../widgets/product_variants_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id, this.categoryId});

  final int id;
  final int? categoryId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    WishlistCubit.get(context).getWishlists();
  }

  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale == const Locale("ar", "EG");
    return BlocProvider(
      lazy: false,
      create: (context) {
        if (widget.categoryId == null) {
          return sl<ProductDetailsBloc>()
            ..add(GetProductDetailsEvent(widget.id))
            ..add(GetProductsDynamicVariantsEvent(widget.id));
        } else {
          return sl<ProductDetailsBloc>()
            ..add(GetProductDetailsEvent(widget.id))
            ..add(GetProductsDynamicVariantsEvent(widget.id))
            ..add(GetSimilarProductsEvent(categoryId: widget.categoryId ?? 1));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTopSectionWidget(isAr: isAr, controller: controller),
                  SizedBox(
                    height: 30.h,
                  ),
                  ProductNameWidget(isAr: isAr),
                  SizedBox(
                    height: 24.h,
                  ),
                  ProductDescriptionWidget(isAr: isAr),
                  SizedBox(
                    height: 15.h,
                  ),
                  const ProductVariantsWidget(),
                  // SizedBox(
                  //   height: 37.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                  //   height: 1.h,
                  //   color: ColorsConstants.lightBlue,
                  // ),
                  // SizedBox(
                  //   height: 26.h,
                  // ),
                  ProductDynamicVariantsWidget(isAr: isAr),
                  // SizedBox(
                  //   height: 37.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                  //   height: 1.h,
                  //   color: ColorsConstants.lightBlue,
                  // ),
                  // SizedBox(
                  //   height: 19.h,
                  // ),
                  BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
                    builder: (context, state) {
                      return ((state.similarProducts == null) ||
                              (state.similarProducts?.length == 0))
                          ? Container()
                          : ProductSimilarWidget(isAr: isAr);
                    },
                  ),
                  SizedBox(
                    height: 120.h,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomSheet: BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
            builder: (context, state) {
          switch (state.productDetailsState) {
            case RequestStates.loading:
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  color: Colors.white,
                  height: 250.h,
                  child: const ShimmerLoader());

            case RequestStates.success:
              return const ProductDetailsBottomSheet();
            case RequestStates.error:
              return Container();
          }
        }),
      ),
    );
  }
}
