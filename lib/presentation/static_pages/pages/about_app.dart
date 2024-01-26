import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/common_widgets/app_bars/app_bar_with_action_button.dart';
import '../../authentication/widgets/custom_loader.dart';
import '../../common_widgets/empty_states/empty_state_without_button.dart';
import '../model_view/static_page_cubit.dart';
import '../model_view/static_page_state.dart';
import '../widgets/static_page_item.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale == const Locale("ar", "EG");
    return Scaffold(
      appBar: AppBarWithActionButton(title: StringsConstants.aboutApp.tr()),
      body: BlocBuilder<StaticPageCubit, StaticPageStates>(
        builder: (context, state) {
          if (state is SuccessStaticPage) {
            return state.data.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(16.r),
                    child: ListView.separated(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return StaticPageItem(
                          title: isAr
                              ? state.data[index].titleAR ?? ''
                              : state.data[index].titleEN ?? '',
                          subTitle: isAr
                              ? state.data[index].descriptionAR ?? ''
                              : state.data[index].descriptionEN ?? '',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12.r);
                      },
                    ),
                  )
                :  EmptyStateWithOutButton(
                    icon: IconsConstants.notFoundResultIC,
                    title: StringsConstants.resultNotFoundTitle.tr(),
                    subTitle: StringsConstants.resultNotFoundSubTitle.tr(),
                  );
          } else if (state is FailureStaticPage) {
            return  EmptyStateWithOutButton(
              icon: IconsConstants.notFoundPageIC,
              title: StringsConstants.pageNotFoundTitle.tr(),
              subTitle: StringsConstants.pageNotFoundTitle.tr(),
            );
          } else if (state is LoadingStaticPage) {
            return const Center(child: CustomLoader());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

///
// class AboutAppScreen extends StatelessWidget {
//   const AboutAppScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBarWithActionButton(title: StringsConstants.aboutApp.tr()),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
//           child: Column(
//             children: [
//               ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//
//                   itemBuilder: (context, index) =>
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset(IconsConstants.solidCircleIC),
//                           SizedBox(width: 7.w,),
//                            Text("""Lorem ipsum dolor sit amet,""",style: Theme.of(context).textTheme.titleMedium,),
//                         ],
//                       ),
//                       SizedBox(height: 7.h,),
//
//                        Padding(
//                          padding:  EdgeInsets.symmetric(horizontal: 15.w),
//                          child: Text(
//                             """Lorem ipsum dolor sit amet, consectetur adipiscing
// elit, sed do eiusmod tempor incididunt ut labore et
// dolore magna aliqua. Ut enim ad minim veniam, quis
// nostrud exercitation ullamco laboris nisi ut aliquip""",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.s14,letterSpacing: -.70,height: 3.h),),
//                        ),
//                       SizedBox(height: 16.h,),
//                       Image.asset(ImagesConstants.background)
//                     ],
//                   ), separatorBuilder: (context, index) =>SizedBox(height: 16.h,), itemCount: 10)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
