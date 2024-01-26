import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/home/model_view/home_bloc.dart';
import 'package:extreme_store/presentation/home/model_view/home_states.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<String> items = [
  "https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=1600",
  "https://images.pexels.com/photos/36717/amazing-animal-beautiful-beautifull.jpg?auto=compress&cs=tinysrgb&w=1600",
  "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg?auto=compress&cs=tinysrgb&w=1600",
  "https://images.pexels.com/photos/807598/pexels-photo-807598.jpeg?auto=compress&cs=tinysrgb&w=1600",
  "https://images.pexels.com/photos/325044/pexels-photo-325044.jpeg?auto=compress&cs=tinysrgb&w=1600",
  "https://c4.wallpaperflare.com/wallpaper/297/22/531/lake-blue-moonlight-moon-wallpaper-preview.jpg"
];

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        switch( state.bannersState){
          case RequestStates.loading:
            return const ShimmerLoader();

          case RequestStates.success:
            return
              Column(
                children: [
                  SizedBox(
                    height: 178.h,
                    // width: 357.w,
                    child: PageView(
                      controller: HomeBloc.get(context).controller,


                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                       state.bannersModel?.bannerMetaModel?.banners?.length ?? 0,
                            (index) =>
                            GestureDetector(
                              onTap: () {
                                if(state. bannersModel?.bannerMetaModel?.banners?[index].productId!=null){
                                  Navigator.of(context).pushNamed(RoutesConstant.productDetails,arguments: [state. bannersModel?.bannerMetaModel?.banners?[index].productId??0,state. bannersModel?.bannerMetaModel?.banners?[index].categoryId??0],);
                                }
                              },
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      // width: 357.w,
                                      height: 176.h,
                                      child: Image.network(

                                        state.bannersModel?.bannerMetaModel?.banners?[index]
                                            .image ?? "",
                                        fit: BoxFit.fill,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(child: SvgPicture.asset(
                                                IconsConstants.placeholder),),
                                      ),
                                    ),


                                    Container()


//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 27.h),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 """Super Flash Sale
// 50% Off""",
//                                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                     color: ColorsConstants.white, fontSize: FontSize.s24.sp),
//                               ),
//                               SizedBox(
//                                 height: 24.h,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                       width: 43.71.w,
//                                       height: 35.12.h,
//                                       decoration: ShapeDecoration(
//                                         color: ColorsConstants.white.withOpacity(.5),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(5)),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           '08',
//                                           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                               fontSize: FontSize.s16.sp, letterSpacing: .5),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       )),
//                                   Container(
//                                     margin:
//                                         EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 8.57.h),
//                                     width: 4.16.w,
//                                     height: 17.99.h,
//                                     child: Text(
//                                       ':',
//                                       textAlign: TextAlign.center,
//                                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                           color: ColorsConstants.white,
//                                           fontSize: FontSize.s18.sp,
//                                           letterSpacing: .08),
//                                     ),
//                                   ),
//                                   Container(
//                                       width: 43.71.w,
//                                       height: 35.12.h,
//                                       decoration: ShapeDecoration(
//                                         color: ColorsConstants.white.withOpacity(.5),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(5)),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           '08',
//                                           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                               fontSize: FontSize.s16.sp, letterSpacing: .5),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       )),
//                                   Container(
//                                     margin:
//                                         EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 8.57.h),
//                                     width: 4.16.w,
//                                     height: 17.99.h,
//                                     child: Text(
//                                       ':',
//                                       textAlign: TextAlign.center,
//                                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                           color: ColorsConstants.white,
//                                           fontSize: FontSize.s18.sp,
//                                           letterSpacing: .08),
//                                     ),
//                                   ),
//                                   Container(
//                                       width: 43.71.w,
//                                       height: 35.12.h,
//                                       decoration: ShapeDecoration(
//                                         color: ColorsConstants.white.withOpacity(.5),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(5)),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           '08',
//                                           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                               fontSize: FontSize.s16.sp, letterSpacing: .5),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       )),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
                                  ],
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  state.bannersModel?.bannerMetaModel?.totalLength == 0
                      ? Container()
                      : SmoothPageIndicator(
                    effect: WormEffect(
                      dotHeight: 7.h,
                      dotWidth: 7.w,
                      activeDotColor: ColorsConstants.black,
                      dotColor: ColorsConstants.lightGray,
                    ),
                    onDotClicked: (index) => HomeBloc.get(context).changeDotIndex(index),
                    controller: HomeBloc.get(context).controller,
                    count: state.bannersModel?.bannerMetaModel?.banners?.length ?? 0,
                  )
                ],
              );


          case RequestStates.error:
            return Container();
        }
      },
    );
  }
}
