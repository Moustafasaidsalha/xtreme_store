import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/best_seller/model_view/best_seller_cubit.dart';
import 'package:extreme_store/presentation/best_seller/model_view/best_seller_states.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/cart_item/cart_item_widget.dart';

import '../../category/pages/category_home.dart';

class BestSellerPage extends StatefulWidget {
  const BestSellerPage({Key? key}) : super(key: key);

  @override
  State<BestSellerPage> createState() => _BestSellerPageState();
}

class _BestSellerPageState extends State<BestSellerPage> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    BestSellerCubit.get(context).firstLoad();
    controller=ScrollController()..addListener(BestSellerCubit.get(context).loadMore);

  }
  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    var cubit=BestSellerCubit.get(context);
    return Scaffold(
      appBar:  AppBarWithActionButton(
        title: StringsConstants.bestSeller.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.w),
        child: BlocBuilder<BestSellerCubit, BestSellerStates>(

          builder: (context, state) {
            return state is GetBestSellerSuccessState?GridView.builder(
              itemCount:cubit.products?.length??0 ,
              itemBuilder: (context, index) =>GestureDetector(
                onTap: () async{
                  // Navigator.of(context).pushNamed(
                  //     RoutesConstant.productDetails,arguments: state.bestSellerProductsModel?.productMetaModel?.products?[index].id??0);
                  Navigator.of(context).pushNamed(RoutesConstant.productDetails,arguments:[state.bestSellerProductsModel?.productMetaModel?.products?[index].id??0 ,state.bestSellerProductsModel?.productMetaModel?.products?[index].categoryId ?? 0], );

                },
                child: CardItemWidget(
                  addToCart: () {
                    Navigator.of(context).pushNamed(RoutesConstant.productDetails,arguments:[state.bestSellerProductsModel?.productMetaModel?.products?[index].id??0 ,state.bestSellerProductsModel?.productMetaModel?.products?[index].categoryId ?? 0], );

                    // context.read<BestSellerCubit>()
                    //     .addProductToCart(
                    //   productModel: cubit.products![index],
                    // );
                  },
                  productImage: cubit.products?[index].images?[0].url??"",
                  productName:isAr?cubit.products![index].nameAr??"":cubit.products?[index].nameEn??"" ,productPrice:cubit.products?[index].price??0 ,),
              ) ,
              controller: controller,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 24.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: .7.h,
                  crossAxisCount: 2,
                ) ,

                ): const ShimmerLoader();
          },
        ),
      ),
    );
  }
}
