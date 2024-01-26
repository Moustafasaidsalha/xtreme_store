import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/ad_screen/model_view/ad_screen_cubit.dart';
import 'package:extreme_store/presentation/ad_screen/model_view/ad_screen_states.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class AdScreenPage extends StatefulWidget {
  const AdScreenPage({super.key});

  @override
  State<AdScreenPage> createState() => _AdScreenPageState();
}

class _AdScreenPageState extends State<AdScreenPage> {
  @override
  void initState() {
    super.initState();
    AdScreenCubit.get(context).getAdScreen(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:   SafeArea(
        child: BlocBuilder<AdScreenCubit, AdScreenStates>(
    builder: (context, state) {
        switch(state.getAddScreenState){
          case RequestStates.loading:
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 80.h,),
                  Container(
width: double.infinity,
                      child: const ShimmerLoader()),
                ],
              ),
            );

          case RequestStates.success:

            return  Stack(
              alignment: Alignment.bottomCenter,
              children: [
               ( state.adScreensModel?.adScreenMetaModel?.totalLength==0)?Container():Container(
                  padding: EdgeInsets.only(left:32.w ,right:32.w ,top:112.h ,bottom: 51.h),
                  color: ColorsConstants.white,

                  child: Image.network(

                    height: 681.h,
                    width: double.infinity,
                    fit: BoxFit.cover

                    ,
                    state.adScreensModel?.adScreenMetaModel?.adScreens?[0].image??"", errorBuilder: (context, error, stackTrace) => SvgPicture.asset(IconsConstants.placeholder),
                    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKLHQroQlQbxKHo2bq2R7YWjP0laOzYJ6xKg&usqp=CAU", errorBuilder: (context, error, stackTrace) => SvgPicture.asset(IconsConstants.placeholder),
                  ),),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(RoutesConstant.homeLanding);
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.w,vertical: 77.h),

                      child: Row(
mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Text(
                            StringsConstants.skip.tr(),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorsConstants.black),
                          ),
                          const Icon(Icons.arrow_forward_ios,),

                        ],
                      ),
                    ),
                  ),
                ),

                ( state.adScreensModel?.adScreenMetaModel?.totalLength==0)?Container():   state.adScreensModel?.adScreenMetaModel?.adScreens?[0].productId!=null? GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushReplacementNamed(RoutesConstant.productDetails,arguments: [ state.adScreensModel?.adScreenMetaModel?.adScreens?[0].productId, state.adScreensModel?.adScreenMetaModel?.adScreens?[0].categoryId]);
                    Navigator.of(context).pushNamed(RoutesConstant.productDetails,arguments: [ state.adScreensModel?.adScreenMetaModel?.adScreens?[0].productId??0, state.adScreensModel?.adScreenMetaModel?.adScreens?[0].categoryId??0]);
                  },

                  child: Opacity(
                    opacity: .5,
                    child: Container(

        decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        ),),
                      height: 58.h,
                      width: 223.w,
                      margin: EdgeInsets.only(bottom: 81.h,),
                      padding: EdgeInsets.symmetric(horizontal:61.w ,vertical: 17.h),
                      child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              StringsConstants.buyNow.tr(),
                            textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorsConstants.white),

                          ),
                          SizedBox(width: 10.w,),
                          const Icon(Icons.arrow_forward,color: Colors.white,)

                        ],
                      ),),
                  ),
                ):Container()
              ],
            );
          case RequestStates.error:
            return Container();

        }
    },
    ),
      ),
    );

  }
}
