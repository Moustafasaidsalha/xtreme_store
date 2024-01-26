import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';
import 'package:extreme_store/presentation/new_in/model_view/new_in_cubit.dart';
import 'package:extreme_store/presentation/new_in/model_view/new_in_state.dart';

import '../../category/pages/category_home.dart';

class NewInPage extends StatefulWidget {
  const NewInPage({Key? key}) : super(key: key);

  @override
  State<NewInPage> createState() => _NewInPageState();
}

class _NewInPageState extends State<NewInPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<NewInCubit>().getProducts();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    // print("scrool ${NewInCubit.get(context).isLoadingMore}");
    if (_isBottom && !NewInCubit.get(context).isLoadingMore) {
      context.read<NewInCubit>().getMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");
    return Scaffold(
      appBar: AppBarWithActionButton(title: StringsConstants.newIn.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.w),
        child: BlocBuilder<NewInCubit, NewInState>(
          builder: (context, state) {
            if (state.stateStatus == StateStatus.success) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: state.newInProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: .7.h,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            // context.read<NewInCubit>().addProductToCart(
                            //       productModel: state.newInProducts[index],
                            //     );
                            Navigator.of(context).pushNamed(
                              RoutesConstant.productDetails,
                              arguments: [
                                state.newInProducts[index].id ?? 0,
                                state.newInProducts[index].categoryId ?? 0
                              ],
                            );
                            // await ProductDetailsCubit.get(context)
                            //     .getProductDetails(state.newInProducts[index].id ?? 0)
                            //     .then((value) =>
                            //         Navigator.of(context).pushNamed(RoutesConstant.productDetails));
                          },
                          child: CardItemWidget(
                            addToCart: () {
                              Navigator.of(context).pushNamed(
                                RoutesConstant.productDetails,
                                arguments: [
                                  state.newInProducts[index].id ?? 0,
                                  state.newInProducts[index].categoryId ?? 0
                                ],
                              );
                              // context.read<NewInCubit>()
                              //   .addProductToCart(
                              //     productModel: state.newInProducts[index],
                              //   );
                            },
                            productImage: state.newInProducts[index].images?[0].url ?? "",
                            productPrice: state.newInProducts[index].price ?? 0,
                            productName: isAr
                                ? state.newInProducts[index].nameAr ?? ""
                                : state.newInProducts[index].nameEn ?? "",
                          ),
                        );
                      },
                    ),
                  ),
                  // state.loadingMore ? const CustomLoader() : const SizedBox(),
                ],
              );
            } else if (state.stateStatus == StateStatus.failure) {
              return const Text("something error");
            } else if (state.stateStatus == StateStatus.loading) {
              return ShimmerLoader();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
