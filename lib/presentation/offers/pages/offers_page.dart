import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/offers/model_view/offer_events.dart';
import 'package:extreme_store/presentation/offers/model_view/offers_cubit.dart';
import 'package:extreme_store/presentation/offers/model_view/offers_states.dart';

import '../../../app/enums/state_status.dart';
import '../../authentication/widgets/custom_loader.dart';
import '../../category/pages/category_home.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<OffersBloc>().add(OffersFetched());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<OffersBloc>().add(OffersFetched());
    }
  }

  // bool get _isBottom {
  //   if (!_scrollController.hasClients) return false;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   return currentScroll >= (maxScroll * 0.9);
  // }

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");
    return Scaffold(
      appBar: AppBarWithActionButton(
        title: StringsConstants.offers.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.h,
          vertical: 16.w,
        ),
        child: BlocBuilder<OffersBloc, OffersState>(
          builder: (context, state) {
            if (state.status == StateStatus.success) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(

                      controller: _scrollController,
                      itemCount:
                          state.hasReachedMax ? state.products.length : state.products.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: .7.h,
                      ),
                      itemBuilder: (context, index) {
                        return index >= state.products.length
                            ? const CustomLoader()
                            : GestureDetector(
                                onTap: () async {
                                  // ProductDetailsBloc.get(context)
                                  //   ..getProductDetails(state.products[index].id ?? 0)..getDynamicVariants(state.products[index].id ?? 0)
                                  //     .then((value) =>
                                  //     Navigator.of(context).pushNamed(RoutesConstant.productDetails));
                                  // Navigator.of(context).pushNamed(
                                  //     RoutesConstant.productDetails,arguments: state.products[index].id??0);
                                  Navigator.of(context).pushNamed(
                                    RoutesConstant.productDetails,
                                    arguments: [
                                      state.products[index].id ?? 0,
                                      state.products[index].categoryId ?? 0
                                    ],
                                  );
                                },
                                child: CardItemWidget(
                                  isOffer: true,
                                  productOfferPrice: state.products[index].offerPrice ?? 0,
                                  addToCart: () {
                                    Navigator.of(context).pushNamed(
                                      RoutesConstant.productDetails,
                                      arguments: [
                                        state.products[index].id ?? 0,
                                        state.products[index].categoryId ?? 0
                                      ],
                                    );
                                    // context.read<OffersBloc>().addProductToCart(
                                    //       productModel: state.products[index],
                                    //     );
                                  },
                                  productImage: state.products[index].images?[0].url ?? "",
                                  productPrice: state.products[index].price ?? 0,
                                  productName: isAr
                                      ? state.products[index].nameAr ?? ""
                                      : state.products[index].nameEn ?? "",
                                ),
                              );
                      },
                    ),
                  ),
                  // OffersCubit.get(context).isMoreLoading ? const CustomLoader() : const SizedBox(),
                ],
              );
            } else if (state.status == StateStatus.failure) {
              return const Text("something error");
            } else if (state.status == StateStatus.initial) {
              return ShimmerLoader();
            } else {
              return const SizedBox();
            }

            // return state is GetOffersSuccessState?GridView.count(
            //     mainAxisSpacing: 24.h,
            //     crossAxisSpacing: 10.w,
            //     childAspectRatio: .7.h,
            //     crossAxisCount: 2,
            //     children: List.generate(
            //       state.offersProductsModel?.productMetaModel?.products?.length??0,
            //           (index) => GestureDetector(
            //             onTap: () async{
            //               await ProductDetailsCubit.get(context).getProductDetails(state.offersProductsModel?.productMetaModel?.products?[index].id??0).then((value) =>    Navigator.of(context).pushNamed(
            //                   RoutesConstant.productDetails));
            //             },
            //             child: CardItemWidget(
            //
            //                 productImage:state. offersProductsModel?.productMetaModel?.products?[index].images?[0].url??"",
            //
            //                 isOffer: true,productPrice:state.offersProductsModel?.productMetaModel?.products?[index].price??0 ,productName:isAr?state.offersProductsModel?.productMetaModel?.products![index].nameAr??"":state.offersProductsModel?.productMetaModel?.products?[index].nameEn??"" ,productOfferPrice:state.offersProductsModel?.productMetaModel?.products?[index].offerPrice??0 ),
            //           ),
            //     )):  Container(child: SvgPicture.asset(IconsConstants.placeholder),);
          },
        ),
      ),
    );
  }
}
