import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import 'package:extreme_store/presentation/common_widgets/dialogs/dialogs.dart';
import 'package:extreme_store/presentation/orders/model_view/orders_cubit.dart';
import 'package:extreme_store/presentation/orders/model_view/orders_states.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

import '../../common_widgets/empty_states/empty_state_without_button.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    OrdersCubit.get(context).getOrders();
  }
  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");
    return Scaffold(
      appBar: AppBarWithActionButton(title: StringsConstants.orders.tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: PaddingValues.p16.w,vertical:  PaddingValues.p16.h),
          child: Column(
            children: [
              BlocBuilder<OrdersCubit, OrdersStates>(
  builder: (context, state) {

    switch(state.ordersState){
      case RequestStates.loading:
        return const ShimmerLoader();

      case RequestStates.success:
        return  (state.ordersDataModel?.length==0)?Column(
          children: [
SizedBox(height: 80.h,),
            EmptyStateWithOutButton(
              icon: IconsConstants.emptyCartIC,
              title: StringsConstants.yourOrderIsEmptyTitle.tr(),
              subTitle: StringsConstants.yourOrderIsEmptySubTitle.tr(),
            ),

          ],
        ):ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              height: 213.h,

              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 5.h),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${StringsConstants.order.tr()} ${state.ordersDataModel?[index].id??0}",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12,color: ColorsConstants.semiBlack)),
                           SizedBox(height: 5.h,),
                            Text("${StringsConstants.placedOn.tr()} ${state.ordersDataModel?[index].day?.split("T").first??""}",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s10))
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                           if (state.ordersDataModel?[index].status=="canceled"){
                             showCustomSnackBar(context,StringsConstants.orderIsCanceled.tr(),color: ColorsConstants.red);

                           }else{
                             Navigator.of(context).pushNamed(RoutesConstant.trackOrder,arguments: state.ordersDataModel?[index].id??0);

                           }
                          },
                          child:  Text(
                            StringsConstants.viewDetails.tr(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12,decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
                    child: Container(
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color:ColorsConstants.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height:92.h,
                        width:92.w,
                        child: Image.network(state.ordersDataModel?[index].subCarts?[0].product?.images?[0].url??"",errorBuilder: (context, error, stackTrace) => SvgPicture.asset(IconsConstants.placeholder,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),)
                      ),
                      SizedBox(width: 17.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 17.h,),

                          Text(isAr?state.ordersDataModel![index].subCarts![0].product?.brand?.nameAr??"":state.ordersDataModel?[index].subCarts?[0].product?.brand?.nameEn??"",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12),),
                          SizedBox(height: 11.h,),
                          SizedBox(
                            // height: 30.h,
                            width:204.w ,

                            child: Text(
                              isAr?state.ordersDataModel![index].subCarts![0].product?.nameAr??"":state.ordersDataModel?[index].subCarts?[0].product?.nameEn??"",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: FontSize.s12),
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          SizedBox(
                            width:204.w ,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${state.ordersDataModel![index].subCarts![0].product?.offer??false?state.ordersDataModel![index].subCarts![0].product?.offerPrice??0:state.ordersDataModel![index].subCarts![0].product?.price??0} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: FontSize.s18)),
                                state.ordersDataModel![index].subCarts![0].product?.offer??false? Stack(
                                  // clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      // right: 2,
                                      // left: 39,
                                      left: -2,
                                      bottom: 11,

                                      child: Transform.rotate(
                                        angle: 2.95,
                                        child: Container(
                                          width: 54.41,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${state.ordersDataModel![index].subCarts![0].product?.price??0} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(

                                          fontSize: FontSize.s14),
                                    ),
                                  ],
                                ):Container(),
                                // Text(
                                //   "40 % OFF",
                                //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12,color: ColorsConstants.green),
                                // )
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h,),

                          // SizedBox(
                          //   width: 103.w,
                          //   child: MainButton(
                          //       margin: 0.w,
                          //       height: 24.h,
                          //       radius: 5.r,
                          //       onPressed: () {},
                          //       color: ColorsConstants.green.withOpacity(.9),
                          //       text: StringsConstants.orderPlaced,
                          //       textStyle: const TextStyle(fontSize: 10)),
                          // ),

                        ],
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 110.w,),
                      ShippingStatusWidget(

                      onTap: () {

                      },
                      textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color:state.ordersDataModel?[index].status==StringsConstants.ordered? ColorsConstants.green:state.ordersDataModel?[index].status==StringsConstants.canceled?ColorsConstants.red:ColorsConstants.black,fontSize: FontSize.s10),
                      backGroundColor:state.ordersDataModel?[index].status==StringsConstants.ordered? ColorsConstants.green.withOpacity(.1):state.ordersDataModel?[index].status==StringsConstants.canceled?ColorsConstants.red.withOpacity(.1):ColorsConstants.lightGrey ,title: state.ordersDataModel?[index].status?.tr()??"",)
                    ],
                  )

                ],
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 24.h,
            ),
            itemCount: state.ordersDataModel?.length??0);
      case RequestStates.error:
        return Container();
    }
  },
),
            ],
          ),
        ),
      ),
    );
  }
}

class ShippingStatusWidget extends StatelessWidget {
   const ShippingStatusWidget({super.key,
   required this.backGroundColor,
   required this.title,
   required this.textStyle,
   required this.onTap,


  });
final Color backGroundColor;
   final String title;
   final TextStyle textStyle;
   final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 107.w,
        height: 30.h,
        decoration: ShapeDecoration(
          color: backGroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        child: Center(child: Text(title,style: textStyle,)),
      ),
    );
//     return SizedBox(
//       // width: 103.w,
//       height: 24.h,
//       child: ReusableElevatedButton(
//           onPressed: () {},
//
//         backGroundColor: backGroundColor,
// textStyle:textStyle ,
//           title: title,
//           ),
//     );
  }
}
