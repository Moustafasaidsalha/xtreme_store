import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/di/injection_container.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/app/utilities/country_utility.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/cart/widgets/total_widget.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/check_out/widgets/address_information_widget.dart';
import 'package:extreme_store/presentation/check_out/widgets/headline_widget.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/track_order/model_view/track_order_cubit.dart';
import 'package:extreme_store/presentation/track_order/model_view/track_order_states.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key, required this.trackOrderId});

  final int trackOrderId;

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  void initState() {
    super.initState();
    TrackOrderCubit.get(context).getTrackOrder(widget.trackOrderId, context);
  }

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${StringsConstants.order.tr()} ${widget.trackOrderId}",
          maxLines: 2,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                height: 0.9,
              ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: BlocBuilder<TrackOrderCubit, TrackOrdersStates>(
            builder: (context, state) {
              switch (state.trackOrderState) {
                case RequestStates.loading:
                  return Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      const ShimmerLoader(),
                    ],
                  );

                case RequestStates.success:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TrackItem(
                                  title: StringsConstants.ordered.tr(),
                                  isEnabled: true,
                                ),
                                TrackItem(
                                  title: StringsConstants.process.tr(),
                                  isEnabled: state.trackOrderModel?.status !=
                                          StringsConstants.ordered
                                      ? true
                                      : false,
                                ),
                                TrackItem(
                                  title: StringsConstants.shipped.tr(),
                                  isEnabled: state.trackOrderModel?.status !=
                                              StringsConstants.ordered &&
                                          state.trackOrderModel?.status !=
                                              StringsConstants.process
                                      ? true
                                      : false,
                                ),
                                TrackItem(
                                  title: StringsConstants.delivered.tr(),
                                  isEnabled: state.trackOrderModel?.status ==
                                          StringsConstants.delivered
                                      ? true
                                      : false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            ((state.trackOrderModel?.status ?? "ordered") ==
                                    "ordered")
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ReusableElevatedButton(
                                        backGroundColor: ColorsConstants.white,
                                        borderColor: ColorsConstants.red,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: ColorsConstants.red),
                                        title:
                                            StringsConstants.cancelOrder.tr(),
                                        onPressed: () {
                                          TrackOrderCubit.get(context)
                                              .cancelOrder(
                                                  context: context,
                                                  orderId: state.trackOrderModel
                                                          ?.id ??
                                                      0);
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  )
                                : Container(),
                            HeadlineWidget(
                              title: StringsConstants.shippingAddress.tr(),
                            ),
                            const AddressInformationWidget(),
                            HeadlineWidget(
                              title: StringsConstants.orderSummery.tr(),
                            ),
                            TotalWidget(
                              numOfItems:
                                  state.trackOrderModel?.subCarts?.length ?? 0,
                              discountAmount:
                                  state.trackOrderModel?.couponValue ?? 0,
                              currency: CountryUtility.countriesDataList
                                  .firstWhere((element) =>
                                      element.id ==
                                      sl<UserPreferenceRepo>()
                                          .getSelectedCountryID())
                                  .currency,
                              shippingFees:
                                  state.trackOrderModel?.shippingFee ?? 0,
                              subTotal: state.trackOrderModel?.subTotal ?? 0,
                              total: state.trackOrderModel?.total ?? 0,
                              cashOnDelivery: 0,

                              ///TODO we don't have cash on delivery
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<TrackOrderCubit, TrackOrdersStates>(
                        builder: (context, state) {
                          switch (state.trackOrderState) {
                            case RequestStates.loading:
                              return const ShimmerLoader();

                            case RequestStates.success:
                              return Container(
                                height: 171.h,
                                padding: EdgeInsets.only(
                                    left: 12.w, right: 12.w, bottom: 15.h),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Container(
                                          height: 171.h,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                          ),
                                          child: Column(
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     Padding(
                                              //       padding:  EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 5.h),
                                              //       child:  Column(
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Text("${state.trackOrderModel?..subCarts[index]id??0}",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12,color: ColorsConstants.semiBlack)),
                                              //           Text("Placed on ${state.ordersDataModel?[index].day?.split("T").first??""}",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s10))
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     const Spacer(),
                                              //     TextButton(
                                              //         onPressed: () {
                                              //           Navigator.of(context).pushNamed(RoutesConstant.trackOrder,arguments: state.ordersDataModel?[index].id??0);
                                              //         },
                                              //         child:  Text(
                                              //           StringsConstants.viewDetails.tr(),
                                              //           style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12,decoration: TextDecoration.underline),
                                              //         ))
                                              //   ],
                                              // ),
                                              // SizedBox(
                                              //   height: 5.h,
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Container(
                                                  decoration:
                                                      const ShapeDecoration(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 0.50,
                                                        strokeAlign: BorderSide
                                                            .strokeAlignCenter,
                                                        color: ColorsConstants
                                                            .lightBlue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      height: 92.h,
                                                      width: 92.w,
                                                      child: Image.network(
                                                        state
                                                                .trackOrderModel
                                                                ?.subCarts?[
                                                                    index]
                                                                .product
                                                                ?.images?[0]
                                                                .url ??
                                                            "",
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            SvgPicture.asset(
                                                                IconsConstants
                                                                    .placeholder),
                                                      )),
                                                  SizedBox(
                                                    width: 17.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 17.h,
                                                      ),
                                                      Text(
                                                        isAr
                                                            ? state
                                                                    .trackOrderModel
                                                                    ?.subCarts![
                                                                        0]
                                                                    .product
                                                                    ?.brand
                                                                    ?.nameAr ??
                                                                ""
                                                            : state
                                                                    .trackOrderModel
                                                                    ?.subCarts?[
                                                                        0]
                                                                    .product
                                                                    ?.brand
                                                                    ?.nameEn ??
                                                                "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                fontSize:
                                                                    FontSize
                                                                        .s12),
                                                      ),
                                                      SizedBox(
                                                        height: 11.h,
                                                      ),
                                                      SizedBox(
                                                        // height: 30.h,
                                                        width: 204.w,

                                                        child: Text(
                                                          isAr
                                                              ? state
                                                                      .trackOrderModel
                                                                      ?.subCarts![
                                                                          0]
                                                                      .product
                                                                      ?.nameAr ??
                                                                  ""
                                                              : state
                                                                      .trackOrderModel
                                                                      ?.subCarts?[
                                                                          0]
                                                                      .product
                                                                      ?.nameEn ??
                                                                  "",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  fontSize:
                                                                      FontSize
                                                                          .s12),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      SizedBox(
                                                        width: 204.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "${state.trackOrderModel?.subCarts![index].product?.offer ?? false ? state.trackOrderModel?.subCarts![index].product?.offerPrice ?? 0 : state.trackOrderModel?.subCarts![index].product?.price ?? 0} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleLarge!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            FontSize.s18)),
                                                            state
                                                                        .trackOrderModel
                                                                        ?.subCarts![
                                                                            index]
                                                                        .product
                                                                        ?.offer ??
                                                                    false
                                                                ? Stack(
                                                                    // clipBehavior: Clip.none,
                                                                    children: [
                                                                      Positioned(
                                                                        // right: 2,
                                                                        // left: 39,
                                                                        left:
                                                                            -2,
                                                                        bottom:
                                                                            11,

                                                                        child: Transform
                                                                            .rotate(
                                                                          angle:
                                                                              2.95,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                54.41,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                                width: 1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${state.trackOrderModel?.subCarts![index].product?.price ?? 0} ${CountryUtility.countriesDataList.firstWhere((element) => element.id == sl<UserPreferenceRepo>().getSelectedCountryID()).currency}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall!
                                                                            .copyWith(fontSize: FontSize.s14),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            // Text(
                                                            //   "40 % OFF",
                                                            //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s12,color: ColorsConstants.green),
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                      Text(
                                                          "${StringsConstants.quantity.tr()} : ${state.trackOrderModel?.subCarts?[index].amount ?? 0}")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                    itemCount: state.trackOrderModel?.subCarts
                                            ?.length ??
                                        0),
                              );
                            case RequestStates.error:
                              return Container();
                          }
                        },
                      ),
                      ReusableElevatedButton(
                        title: StringsConstants.continueShopping.tr(),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RoutesConstant.homeLanding,
                            (route) => false,
                          );
                        },
                      ),
                      SizedBox(height: 28.r),
                    ],
                  );
                case RequestStates.error:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class TrackItem extends StatelessWidget {
  const TrackItem({
    super.key,
    required this.title,
    required this.isEnabled,
  });

  final String title;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor =
        isEnabled ? ColorsConstants.green : ColorsConstants.gray2;
    final Color textColor =
        isEnabled ? ColorsConstants.green : ColorsConstants.gray1;
    return Column(
      children: [
        Container(
          height: 16,
          width: 85,
          decoration: BoxDecoration(
              color: foregroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              )),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset(
              IconsConstants.tickCircle,
              colorFilter: ColorFilter.mode(
                textColor,
                BlendMode.srcIn,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: textColor,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
