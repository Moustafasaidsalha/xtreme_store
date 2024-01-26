import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/common_widgets/empty_states/empty_state_with_button.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_cubit.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_states.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({Key? key, required this.userPreferenceRepo}) : super(key: key);
  UserPreferenceRepo userPreferenceRepo;

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    WishlistCubit.get(context).getWishlists();
  }

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Scaffold(
      appBar: AppBarWithActionButton(title: StringsConstants.wishlist.tr()),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingValues.p16.w, vertical: PaddingValues.p16.h),
            child: Column(
              // children: [
              //   Row(
              //     children: [
              //       Container(
              //           width: AppSize.s300.w,
              //           child: SearchBarWidget()),
              //       SizedBox(
              //         width: AppSize.s16.w,
              //       ),
              //       Container(
              //
              //           height: AppSize.s40.h,
              //           width: AppSize.s40.w,
              //           color: ColorsConstants.lightGray,
              //           child: Padding(
              //             padding:  EdgeInsets.all(PaddingValues.p8.h),
              //             child: SvgPicture.asset(IconsConstants.searchPrefIC),
              //           ))
              //     ],
              //   ),
              //   isEmpty? Container()
              //       : length == 0
              //           ? Column(
              //               children: [
              //                 SizedBox(
              //                   height: AppSize.s32.h,
              //                 ),
              //                 Row(
              //                   children: [
              //                     Text(StringsConstants.recentSearches),
              //                     Spacer(),
              //                     GestureDetector(
              //                       child: SizedBox(
              //                           // width: 39.w,
              //                           height: AppSize.s20.h,
              //                           child: Text(StringsConstants.clear)),
              //                       onTap: () {},
              //                     )
              //                   ],
              //                 ),
              //                 SizedBox(
              //                   height: 34.h,
              //                 ),
              //                 ListView.separated(
              //                     shrinkWrap: true,
              //                     itemBuilder: (context, index) => Container(
              //                           margin: EdgeInsets.only(
              //                               bottom: 16.h, top: 16.h),
              //                           child: Text("LAP Top"),
              //                         ),
              //                     separatorBuilder: (context, index) => Opacity(
              //                           opacity: 0.10,
              //                           child: Container(
              //                             width: 358,
              //                             decoration: ShapeDecoration(
              //                               shape: RoundedRectangleBorder(
              //                                 side: BorderSide(
              //                                   width: 0.50,
              //                                   strokeAlign: BorderSide
              //                                       .strokeAlignCenter,
              //                                   color: Color(0xFF8E9AA0),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                     itemCount: 3)
              //               ],
              //             )
              //           : notFound
              //               ? Column(
              //                   children: [
              //                     SizedBox(
              //                       height: 56.h,
              //                     ),
              //                     Center(
              //                         child: Image.asset(
              //                             ImagesConstants.notFound)),
              //                     SizedBox(
              //                       height: 30.h,
              //                     ),
              //                     Text(StringsConstants.resultNotFound,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: FontSize.s28),),
              //                     SizedBox(
              //                       height: 8.h,
              //                     ),
              //                     Container(
              //                       margin: EdgeInsets.symmetric(horizontal: MarginValues.m30),
              //                         child: Text(StringsConstants.tryAgain,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsConstants.gray,fontSize: FontSize.s18,height: AppSize.s1_5.sp),textAlign: TextAlign.center,)),
              //                     SizedBox(
              //                       height: 176.h,
              //                     ),
              //                     MainButton(margin:MarginValues.m10, height: AppSize.s58.h, radius: AppSize.s10.r, onPressed: () {
              //
              //                     }, color: ColorsConstants.black, text: StringsConstants.searchAgain, textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsConstants.white,fontSize: FontSize.s18))
              //                   ],
              //                 )
              //               : GridView.count(
              //                   shrinkWrap: true,
              //                   physics: NeverScrollableScrollPhysics(),
              //                   mainAxisSpacing: 24.h,
              //                   crossAxisSpacing: 10.w,
              //                   childAspectRatio: .8.h,
              //                   crossAxisCount: 2,
              //                   children: List.generate(
              //                       10,
              //                       (index) => CardItem())),
              // ],
              children: [
                WishlistCubit.get(context)
                        .userPreferenceRepo
                        .getAccessToken()
                        .isEmpty
                    ? EmptyStateWithButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonText: StringsConstants.goBack.tr(),
                        icon: IconsConstants.notFoundPageIC,
                        title: StringsConstants.noOrdersPlacedYetTitle.tr(),
                        subTitle:
                            StringsConstants.noOrdersPlacedYeSubTitle.tr(),
                      )
                    : BlocBuilder<WishlistCubit, WishlistStates>(
                        // buildWhen: (previous, current) => current is GetWishListSuccessState,
                        builder: (context, state) {
                          switch (state.getWishListState) {
                            case RequestStates.loading:
                              return const ShimmerLoader();

                            case RequestStates.success:
                              return   state.wishlistsModel?.wishlistMetaModel?.products?.isEmpty??true ? Column(
                                children: [
                                  SizedBox(height: 80.h,),

                                  EmptyStateWithButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    buttonText: StringsConstants.goBack.tr(),
                                    icon: IconsConstants.noFavouriteIC,
                                    title: StringsConstants.noFavouritesTitle.tr(),
                                    subTitle: StringsConstants.noFavouritesSubTitle.tr(),
                                  ),
                                ],
                              ) : GridView.builder(
                                itemCount: state.wishlistsModel
                                        ?.wishlistMetaModel?.products?.length ??
                                    0,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () async {
                                    // await ProductDetailsBloc.get(context)..getProductDetails(state.wishlistsModel?.wishlistMetaModel?.products?[index].id??0)..getDynamicVariants(state.wishlistsModel?.wishlistMetaModel?.products?[index].id??0).then((value) =>    Navigator.of(context).pushNamed(
                                    //     RoutesConstant.productDetails));
                                    // Navigator.of(context).pushNamed(
                                    //     RoutesConstant.productDetails,
                                    //     arguments: state
                                    //             .wishlistsModel
                                    //             ?.wishlistMetaModel
                                    //             ?.products?[index]
                                    //             .id ??
                                    //         0);
                                    Navigator.of(context).pushNamed(
                                      RoutesConstant.productDetails,
                                      arguments: [
                                        state
                                            .wishlistsModel
                                            ?.wishlistMetaModel
                                            ?.products?[index].productModel?.id ?? 0,
                                        state
                                            .wishlistsModel
                                            ?.wishlistMetaModel
                                            ?.products?[index].productModel?.categoryId ?? 0
                                      ],
                                    );
                                  },
                                  child: CardItemWidget(

                                    removeFromWishlist: () {
                                      WishlistCubit.get(context).deleteWishlist(
                                          state
                                              .wishlistsModel
                                              ?.wishlistMetaModel
                                              ?.products?[index]
                                              .productId ??
                                              0);
                                    },
                                    productImage: state
                                            .wishlistsModel
                                            ?.wishlistMetaModel
                                            ?.products?[index]
                                            .productModel
                                            ?.images?[0]
                                            .url ??
                                        "",
                                    productPrice: state
                                            .wishlistsModel
                                            ?.wishlistMetaModel
                                            ?.products?[index]
                                            .productModel
                                            ?.price ??
                                        0,
                                    productName: isAr
                                        ? state
                                                .wishlistsModel
                                                ?.wishlistMetaModel
                                                ?.products![index]
                                                .productModel
                                                ?.nameAr ??
                                            ""
                                        : state
                                                .wishlistsModel
                                                ?.wishlistMetaModel
                                                ?.products?[index]
                                                .productModel
                                                ?.nameEn ??
                                            "",
                                    productOfferPrice: state
                                            .wishlistsModel
                                            ?.wishlistMetaModel
                                            ?.products?[index]
                                            .productModel
                                            ?.offerPrice ??
                                        0,
                                    isOffer: state
                                            .wishlistsModel
                                            ?.wishlistMetaModel
                                            ?.products?[index]
                                            .productModel
                                            ?.offer ??
                                        false,
                                    isWishlist: true,
                                  ),
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 24.h,
                                  crossAxisSpacing: 10.w,
                                  childAspectRatio: .6.h,
                                  crossAxisCount: 2,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                              );
                            case RequestStates.error:
                              return Container(
                                child: SvgPicture.asset(
                                    IconsConstants.placeholder),
                              );
                          }

                          // state is GetWishListSuccessState? GridView.builder(
                          //   itemCount: state.wishlistsModel?.wishlistMetaModel?.products?.length??0,
                          //     itemBuilder: (context, index) => GestureDetector(
                          //       onTap: () async{
                          //         // await ProductDetailsBloc.get(context)..getProductDetails(state.wishlistsModel?.wishlistMetaModel?.products?[index].id??0)..getDynamicVariants(state.wishlistsModel?.wishlistMetaModel?.products?[index].id??0).then((value) =>    Navigator.of(context).pushNamed(
                          //         //     RoutesConstant.productDetails));
                          //         Navigator.of(context).pushNamed(
                          //             RoutesConstant.productDetails,arguments: state.wishlistsModel?.wishlistMetaModel?.products?[index].id??0);
                          //       },
                          //       child: CardItemWidget(
                          //         onTap: () {
                          //           WishlistCubit.get(context).deleteWishlist(state.wishlistsModel?.wishlistMetaModel?.products?[index].productId??0);
                          //         },
                          //         productImage: state.wishlistsModel?.wishlistMetaModel?.products?[index].productModel?.images?[0].url??"",
                          //
                          //         productPrice: state.wishlistsModel?.wishlistMetaModel?.products?[index].productModel?.price??0,
                          //         productName:isAr?state.wishlistsModel?.wishlistMetaModel?.products![index].productModel?.nameAr??"":state.wishlistsModel?.wishlistMetaModel?.products?[index].productModel?.nameEn??"" ,
                          //         productOfferPrice: state.wishlistsModel?.wishlistMetaModel?.products?[index].productModel?.offerPrice??0,
                          //         isOffer: state.wishlistsModel?.wishlistMetaModel?.products?[index].productModel?.offer??false,
                          //         isWishlist: true,
                          //       ),
                          //     ),
                          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //       mainAxisSpacing: 24.h,
                          //       crossAxisSpacing: 10.w,
                          //       childAspectRatio: .6.h,
                          //       crossAxisCount: 2,
                          //     ),
                          //                     physics: const NeverScrollableScrollPhysics(),
                          //                     shrinkWrap: true,
                          //
                          //                  ):Container(child: SvgPicture.asset(IconsConstants.placeholder),);
                        },
                      )
              ],
            )),
      ),
    );
  }
}
