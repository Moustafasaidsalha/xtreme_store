import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/common_widgets/empty_states/empty_state_with_button.dart';
import 'package:extreme_store/presentation/common_widgets/text_fields/text_field_with_prefix.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/search/model_view/search_cubit.dart';
import 'package:extreme_store/presentation/search/model_view/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  final int length = 0;
  final isEmpty = true;
  final notFound = true;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");
    int? subCategoryId;
    int? categoryId;
    String? sortById;
    return Scaffold(
      appBar: AppBarWithActionButton(title: StringsConstants.search.tr()),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     ,
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         icon: SvgPicture.asset(IconsConstants.arrowRightBarIC))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingValues.p16.w, vertical: PaddingValues.p16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    // Container(
                    //   height: AppSize.s40.h,
                    //   width: double.infinity,
                    //   color: ColorsConstants.semiGrey,
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //         prefixIcon: Container(
                    //             padding:
                    //                 const EdgeInsets.symmetric(vertical: 8),
                    //             child:
                    //                 SvgPicture.asset(IconsConstants.searchIC)),
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(8))),
                    //   ),
                    // ),
                    SizedBox(
                        width: AppSize.s300.w,
                        child: TextFieldWithPrefix(
                          onSubmitted: (p0) {},
                          onChanged: (input) {
                            input.isEmpty
                                ? {}
                                : SearchCubit.get(context)
                                    .searchProducts(name: input);
                          },
                          havePrefix: true,
                          prefixIcon: IconsConstants.searchIC,
                          hintText: StringsConstants.searchOrProducts.tr(),
                          isEnabled: true,
                        )),
                    SizedBox(
                      width: AppSize.s16.w,
                    ),
                    BlocBuilder<SearchCubit, SearchStates>(
                      buildWhen: (previous, current) =>
                          current.searchState != previous.searchState &&
                          current.products?.length != previous.products?.length,
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            // sl<SearchCubit>().showFilter(context: context,subCategoryId:subCategoryId ,categoryId: categoryId,sortById: sortById);
                            SearchCubit.get(context).showFilter(
                                context: context,
                                subCategoryId: subCategoryId,
                                categoryId: categoryId,
                                sortById: sortById);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: ColorsConstants.lightBlue,
                                  borderRadius: BorderRadius.circular(5.r)),
                              height: AppSize.s40.h,
                              width: AppSize.s40.w,
                              child: Padding(
                                padding: EdgeInsets.all(PaddingValues.p8.h),
                                child: SvgPicture.asset(
                                    IconsConstants.searchPrefIC,
                                    colorFilter: ColorFilter.mode(
                                        ColorsConstants.iconsColor,
                                        BlendMode.srcIn)),
                              )),
                        );
                      },
                    )
                  ],
                ),
                // isEmpty? Container()
                //     : length == 0
                //         ? Column(
                //             children: [
                //               SizedBox(
                //                 height: AppSize.s32.h,
                //               ),
                //               Row(
                //                 children: [
                //                   Text(StringsConstants.recentSearches,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsConstants.semiBlack)),
                //                   const Spacer(),
                //                   GestureDetector(
                //                     child: SizedBox(
                //                         // width: 39.w,
                //                         height: AppSize.s20.h,
                //                         child: Text(StringsConstants.clear,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsConstants.semiBlack),)),
                //                     onTap: () {},
                //                   )
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 34.h,
                //               ),
                //               ListView.separated(
                //                   shrinkWrap: true,
                //                   itemBuilder: (context, index) => Container(
                //                         margin: EdgeInsets.only(
                //                             bottom: 16.h, top: 16.h),
                //                         child: Text("LAP Top",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12),),
                //                       ),
                //                   separatorBuilder: (context, index) => Opacity(
                //                         opacity: 0.10,
                //                         child: Container(
                //                           width: 358,
                //                           decoration: const ShapeDecoration(
                //                             shape: RoundedRectangleBorder(
                //                               side: BorderSide(
                //                                 width: 0.50,
                //                                 strokeAlign: BorderSide
                //                                     .strokeAlignCenter,
                //                                 color: Color(0xFF8E9AA0),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                   itemCount: 3)
                //             ],
                //           )
                //         : notFound
                //             ? Column(
                //                 children: [
                //                   SizedBox(
                //                     height: 56.h,
                //                   ),
                //                   Center(
                //                       child: SvgPicture.asset(
                //                           IconsConstants.notFoundResultIC)),
                //                   SizedBox(
                //                     height: 30.h,
                //                   ),
                //                   Text(StringsConstants.resultNotFoundTitle,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: FontSize.s28),),
                //                   SizedBox(
                //                     height: 8.h,
                //                   ),
                //                   Container(
                //                     margin: const EdgeInsets.symmetric(horizontal: MarginValues.m30),
                //                       child: Text(StringsConstants.resultNotFoundSubTitle,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsConstants.gray,fontSize: FontSize.s18,height: AppSize.s1_5.sp),textAlign: TextAlign.center,)),
                //                   SizedBox(
                //                     height: 176.h,
                //                   ),
                //                   MainButton(margin:MarginValues.m10, height: AppSize.s58.h, radius: AppSize.s10.r, onPressed: () {
                //
                //                   }, color: ColorsConstants.black, text: StringsConstants.searchAgain, textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsConstants.white,fontSize: FontSize.s18))
                //                 ],
                //               )
                //             : GridView.builder(
                //   itemCount: state.productsModel?.productMetaModel?.products?.length??0,
                //   itemBuilder: (context, index) => CardItemWidget(
                //     productImage:state.productsModel?.productMetaModel?.products?[index].images?[0].url??"",
                //
                //     isOffer:state.productsModel?.productMetaModel?.products?[index].offer??false,productName:isAr?state.productsModel?.productMetaModel?.products![index].nameAr??"":state.productsModel?.productMetaModel?.products?[index].nameEn??"" ,productPrice: state.productsModel?.productMetaModel?.products?[index].price??0,),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     mainAxisSpacing: 24.h,
                //     crossAxisSpacing: 10.w,
                //     childAspectRatio: .8.h,
                //     crossAxisCount: 2,
                //   ),
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //
                // ),
                BlocBuilder<SearchCubit, SearchStates>(
                  builder: (context, state) {
                    switch (state.searchState) {
                      case RequestStates.loading:
                        return Container();

                      case RequestStates.success:
                        return (state.products?.length) == 0
                            ? EmptyStateWithButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                buttonText: StringsConstants.goBack.tr(),
                                icon: IconsConstants.notFoundResultIC,
                                title:
                                    StringsConstants.resultNotFoundTitle.tr(),
                                subTitle: StringsConstants
                                    .resultNotFoundSubTitle
                                    .tr(),
                              )
                            : GridView.builder(
                                itemCount: state.products?.length ?? 0,
                                itemBuilder: (context, index) => CardItemWidget(
                                  productImage:
                                      state.products?[index].images?[0].url ??
                                          "",
                                  isOffer:
                                      state.products?[index].offer ?? false,
                                  productName: isAr
                                      ? state.products![index].nameAr ?? ""
                                      : state.products?[index].nameEn ?? "",
                                  productPrice:
                                      state.products?[index].price ?? 0,
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 24.h,
                                  crossAxisSpacing: 10.w,
                                  childAspectRatio: .8.h,
                                  crossAxisCount: 2,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              );
                      case RequestStates.error:
                        return Container();
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
