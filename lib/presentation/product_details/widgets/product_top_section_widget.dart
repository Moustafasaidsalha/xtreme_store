import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_cubit.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_states.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductTopSectionWidget extends StatefulWidget {
  const ProductTopSectionWidget({
    super.key,
    required this.isAr,
    required this.controller,
  });

  final bool isAr;
  final PageController controller;

  @override
  State<ProductTopSectionWidget> createState() =>
      _ProductTopSectionWidgetState();
}

class _ProductTopSectionWidgetState extends State<ProductTopSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.h),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Transform.flip(
                        flipX: widget.isAr ? false : true,
                        child: SvgPicture.asset(IconsConstants.arrowRightBarIC,
                            colorFilter: ColorFilter.mode(
                                ColorsConstants.iconsColor, BlendMode.srcIn)),
                      )),
                  sl<UserPreferenceRepo>().getAccessToken().isEmpty
                      ? BlocBuilder<WishlistCubit, WishlistStates>(
                          builder: (context, state0) {
                            return BlocBuilder<ProductDetailsBloc,
                                ProductDetailsStates>(
                              builder: (context, state1) {
                                return GestureDetector(
                                    onTap: () {
                                      state0.wishlistsModel?.wishlistMetaModel?.products
                                                  ?.any((element) =>
                                                      element.productModel?.id ==
                                                      state1.productDataModel
                                                          ?.productModel?.id) ??
                                              false == true
                                          ? WishlistCubit.get(context)
                                              .deleteWishlist(state1
                                                      .productDataModel
                                                      ?.productModel
                                                      ?.id ??
                                                  0)
                                          : WishlistCubit.get(context).setWishlist(
                                              state1.productDataModel
                                                      ?.productModel?.id ??
                                                  0,
                                              context);
                                      // ProductDetailsBloc.get(context).add(SetWishListEvent(
                                      //     context: context,
                                      //     productId: state1
                                      //     .productDataModel
                                      //     ?.productModel
                                      //     ?.id ??
                                      //     0));
                                      // WishlistCubit.get(context).getWishlists();
                                      // WishlistCubit.get(context).getWishlists();
                                    },
                                    child: state0.wishlistsModel
                                                ?.wishlistMetaModel?.products
                                                ?.any((element) =>
                                                    element.productModel?.id ==
                                                    state1.productDataModel
                                                        ?.productModel?.id) ??
                                            false == true
                                        ?
                                        // SvgPicture.asset(
                                        // IconsConstants.heartIC,colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),):
                                        const Icon(
                                            Icons.favorite,
                                            color: ColorsConstants.red,
                                          )
                                        : SvgPicture.asset(
                                            IconsConstants.heartIC));
                              },
                            );
                          },
                        )
                      : BlocBuilder<WishlistCubit, WishlistStates>(
                          builder: (context, state0) {
                            switch (state0.getWishListState) {
                              case RequestStates.loading:
                                return const ShimmerLoader();

                              case RequestStates.success:
                                return BlocBuilder<ProductDetailsBloc,
                                    ProductDetailsStates>(
                                  builder: (context, state1) {
                                    return GestureDetector(
                                        onTap: () {
                                          state0
                                                      .wishlistsModel
                                                      ?.wishlistMetaModel
                                                      ?.products
                                                      ?.any((element) =>
                                                          element.productModel?.id ==
                                                          state1
                                                              .productDataModel
                                                              ?.productModel
                                                              ?.id) ??
                                                  false == true
                                              ? WishlistCubit.get(context)
                                                  .deleteWishlist(state1
                                                          .productDataModel
                                                          ?.productModel
                                                          ?.id ??
                                                      0)
                                              : WishlistCubit.get(context)
                                                  .setWishlist(
                                                      state1.productDataModel?.productModel?.id ?? 0,
                                                      context);
                                          // ProductDetailsBloc.get(context).add(SetWishListEvent(
                                          //     context: context,
                                          //     productId: state1
                                          //     .productDataModel
                                          //     ?.productModel
                                          //     ?.id ??
                                          //     0));
                                          // WishlistCubit.get(context).getWishlists();
                                          // WishlistCubit.get(context).getWishlists();
                                        },
                                        child: state0
                                                    .wishlistsModel
                                                    ?.wishlistMetaModel
                                                    ?.products
                                                    ?.any((element) =>
                                                        element
                                                            .productModel?.id ==
                                                        state1
                                                            .productDataModel
                                                            ?.productModel
                                                            ?.id) ??
                                                false == true
                                            ?
                                            // SvgPicture.asset(
                                            // IconsConstants.heartIC,colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),):
                                            const Icon(
                                                Icons.favorite,
                                                color: ColorsConstants.red,
                                              )
                                            : SvgPicture.asset(
                                                IconsConstants.heartIC));
                                  },
                                );

                              case RequestStates.error:
                                return Container();
                            }
                          },
                        ),
                ],
              ),
              SizedBox(
                height: 34.h,
              ),
              BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () async {
                        final box = context.findRenderObject() as RenderBox?;
                        await Share.share(
                          'https://xtremestorekw.com/products/productdetails/${state.productDataModel?.productModel?.id}',
                          subject: 'Share',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                      child: SvgPicture.asset(IconsConstants.shareIC,
                          colorFilter: ColorFilter.mode(
                              ColorsConstants.iconsColor, BlendMode.srcIn)));
                },
              ),
            ],
          ),
          BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
            // buildWhen: (previous, current) =>
            //     previous is GetProductDetailsSuccessState,
            builder: (context, state) {
              switch (state.productDetailsState) {
                case RequestStates.loading:
                  return const ShimmerLoader();

                case RequestStates.success:
                  return Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      SizedBox(
                        height: 194.h,
                        width: 194.w,
                        child: PageView(
                          controller: widget.controller,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              state.productDataModel?.productModel?.images
                                      ?.length ??
                                  0,
                              (index) => Container(
                                  // clipBehavior:
                                  // Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Image.network(
                                    state.productDataModel?.productModel
                                            ?.images?[index].url ??
                                        "",
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            SvgPicture.asset(
                                                IconsConstants.placeholder),
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SmoothPageIndicator(
                          effect: WormEffect(dotHeight: 7.h, dotWidth: 7.w),

                          // onDotClicked: (index) => cubit.changeDotIndex(index),
                          controller: widget.controller,
                          count: state.productDataModel?.productModel?.images
                                  ?.length ??
                              1)
                    ],
                  );

                case RequestStates.error:
                  return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
