import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/data/models/add_to_cart_body.dart';

import '../../../app/constants/fonts_constants.dart';
import '../../../app/constants/strings_constants.dart';
import '../../../app/di/injection_container.dart';
import '../../../app/utilities/country_utility.dart';
import '../../../domain/repositories/user_preference_repo.dart';
import '../../common_widgets/buttons/reusable_elevated_button.dart';
import '../model_view/product_details_bloc.dart';
import '../model_view/product_details_states.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  const ProductDetailsBottomSheet({super.key});

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet> {
  int currentValue = 1;
  List<int> items = [];
  double totalWithQuantity = 0;
  @override
  void initState() {
    super.initState();
    currentValue = ProductDetailsBloc.get(context).amount;
    items = ProductDetailsBloc.get(context).amountLength;
  }

  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale == const Locale("ar", "EG");

    return Container(
      height: 126.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: ShapeDecoration(
        color: ColorsConstants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringsConstants.totalPrice.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: FontSize.s9.sp)),
          // BlocConsumer<ProductDetailsBloc, ProductDetailsStates>(
          //   listener: (context, state) {},
          //   listenWhen: (previous, current) => previous.isSelectedState!=current.isSelectedState||previous.isSelectedState==current.isSelectedState||previous.addToListState!=current.addToListState||previous.removeFromListState!=current.removeFromListState,
          //   builder: (context, state) {
          //     //isSelectedState addToListState removeFromListState
          //     return Text(" ${ProductDetailsBloc.get(context).totalPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id==sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
          //         style: Theme.of(context)
          //             .textTheme
          //             .titleLarge!
          //             .copyWith(fontSize: FontSize.s18.sp));
          //     // switch(state.productDetailsState){
          //     //   case RequestStates.loading:
          //     //     return Container();
          //     //   case RequestStates.success:
          //     //     // return Text(" ${state.productDataModel?.productModel?.offer??false?state.productDataModel?.productModel?.offerPrice??0:state.productDataModel?.productModel?.price??0} ${CountryUtility.countriesDataList.firstWhere((element) => element.id==sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
          //     //
          //     //   case RequestStates.error:
          //     //     return Container();
          //     // }
          //
          //   },
          // ),
          BlocConsumer<ProductDetailsBloc, ProductDetailsStates>(
            listener: (context, state) {
              // This block will be executed when any of the specified states change.
              // You can add your logic here.
            },
            listenWhen: (previous, current) {
              // Return true to rebuild the UI whenever any of these states change.
              // return previous.isSelectedState != current.isSelectedState ||
              //     previous.addToListState != current.addToListState ||
              //     previous.removeFromListState != current.removeFromListState;
              // return previous!=current;
              return previous.totalPrice == current.totalPrice;
            },
            // buildWhen: (previous, current) => previous.totalPrice!=current.totalPrice,
            builder: (context, state) {
              // This is the UI part that will be rebuilt when any of the specified states change.
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    " ${state.totalPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                    // " ${state.totalPrice} ${CountryUtility.countriesDataList.firstWhere((element) => element.id==sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: FontSize.s18.sp),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        // width: 79.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 5.w),
                        decoration: BoxDecoration(
                            color: ColorsConstants.lightBlue,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text("${StringsConstants.qty.tr()} :"),

                            CounterWidget(
                              totalPrice: state.totalPrice ?? 0,
                              onChanged: (value) {
                                totalWithQuantity =
                                    value * (state.totalPrice ?? 0);
                                setState(() {
                                  currentValue = value;
                                  ProductDetailsBloc.get(context).amount =
                                      value;
                                });
//                               ProductDetailsBloc.get(context).add(ChangeQuantityEvent(amount: value,totalPrice: state.totalPrice??0));
//                               setState(() {
// // ProductDetailsBloc.get(context).totalPrice=state.totalPrice??0;
//                               });
                              },
                              initialValue: 1,
                              maxValue: items.length,
                            )
                            // DropdownButton<int>(
                            //
                            //     value: currentValue,
                            //
                            //     items:items.map<DropdownMenuItem<int>>((e) {
                            //
                            //       return DropdownMenuItem(
                            //
                            //         value: e,
                            //         child:e==0?Text(""): Text("${items[e]}"),);
                            //
                            //
                            //     } ).toList(), onChanged: (value) {
                            //
                            //   setState(() {
                            //     ProductDetailsBloc.get(context).amount=value??1;
                            //     currentValue=value??1;
                            //
                            //
                            //   });
                            //
                            // })
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: BlocBuilder<ProductDetailsBloc,
                            ProductDetailsStates>(
                          builder: (context, state) {
                            return ReusableElevatedButton(
                              roundedCorner: 30.r,
                              title: StringsConstants.addToCart.tr(),
                              onPressed: () {
                                print(ProductDetailsBloc.get(context)
                                    .dynamicVariantsList);
                                print(ProductDetailsBloc.get(context).amount);
                                List<DynamicVariant> dynamicVariant = [];
                                if (ProductDetailsBloc.get(context)
                                    .dynamicVariantsList
                                    .isNotEmpty) {
                                  dynamicVariant =
                                      ProductDetailsBloc.get(context)
                                          .dynamicVariantsList
                                          .entries
                                          .map((e) => DynamicVariant(
                                              dynamicVariantId: e.key,
                                              amount:
                                                  e.value.entries.first.key))
                                          .toList();
                                }
                                context
                                    .read<ProductDetailsBloc>()
                                    .addProductToCart(
                                      context: context,
                                      addToCartBody: AddToCartBody(products: [
                                        Products(
                                          productId: state.productDataModel
                                              ?.productModel?.id,
                                          amount:
                                              ProductDetailsBloc.get(context)
                                                  .amount,
                                          dynamicVariant: dynamicVariant,
                                        )
                                      ]),
                                    );

                                ProductDetailsBloc.get(context)
                                    .productDetailsPopUp(context,
                                        cartTotalPrice: (state.totalPrice ??
                                                0) *
                                            ProductDetailsBloc.get(context)
                                                .amount,
                                        productName: isAr
                                            ? state.productDataModel
                                                    ?.productModel?.nameAr ??
                                                ""
                                            : state.productDataModel
                                                    ?.productModel?.nameEn ??
                                                "");
                              },
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final double totalPrice;
  final Function(int) onChanged;

  const CounterWidget({
    super.key,
    required this.initialValue,
    required this.maxValue,
    required this.onChanged,
    required this.totalPrice,
  });

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _increment() {
    if (_counter < widget.maxValue) {
      setState(() {
        _counter++;
        widget.onChanged(_counter);
        // ProductDetailsBloc.get(context).add(ChangeQuantityEvent(amount: _counter,totalPrice: _counter*widget.totalPrice));
      });
    }
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() {
        // ProductDetailsBloc.get(context).add(ChangeQuantityEvent(amount: _counter,totalPrice: widget.totalPrice/_counter));

        _counter--;
        widget.onChanged(_counter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _decrement,
          child: Icon(
            Icons.remove,
          ),
        ),
        Text(
          '$_counter',
        ),
        GestureDetector(
          onTap: _increment,
          child: Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }
}
