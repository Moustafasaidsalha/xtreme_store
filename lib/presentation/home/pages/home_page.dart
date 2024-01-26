import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/constants/values_manager.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/presentation/category/pages/category_home.dart';
import 'package:extreme_store/presentation/home/model_view/home_bloc.dart';
import 'package:extreme_store/presentation/home/model_view/home_event.dart';
import 'package:extreme_store/presentation/home/model_view/home_states.dart';
import 'package:extreme_store/presentation/home/widgets/best_seller_widget.dart';
import 'package:extreme_store/presentation/home/widgets/categories_widget.dart';
import 'package:extreme_store/presentation/home/widgets/new_in_widget.dart';
import 'package:extreme_store/presentation/home/widgets/offers_widget.dart';
import 'package:extreme_store/presentation/home/widgets/search_bar_widget.dart';
import 'package:extreme_store/presentation/home/widgets/slider_widget.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

import '../../../app/services/language_pref.dart';
import '../../addresses/widgets/address_selection_widget.dart';
import 'package:extreme_store/app/di/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    HomeBloc.get(context)
      // ..getAppTheme()
      ..add(GetBannersEvent())
      ..add(GetCategoriesEvent())
      ..add(GetBestSellerEvent())
      ..add(GetNewInEvent())
      ..add(GetOffersEvent());
    HomeBloc.get(context).startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              left: PaddingValues.p16.w, right: PaddingValues.p17.w),
          child: Column(
            children: [
              Localizations.override(
                  context: context,
                  locale: context.locale,
                  child: SearchBarWidget()),
              // const SearchBarWidget(),
              SizedBox(
                height: AppSize.s12.h,
              ),
              BlocBuilder<HomeBloc, HomeStates>(
                // buildWhen: (previous, current) => current is GetBannersSuccessState ,
                buildWhen: (previous, current) =>
                    previous.bannersState != current.bannersState,

                builder: (context, state) {
                  switch (state.bannersState) {
                    case RequestStates.loading:
                      return const ShimmerLoader();

                    case RequestStates.success:
                      return SliderWidget();
                    case RequestStates.error:
                      return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder));
                  }
                },
              ),

              SizedBox(
                height: AppSize.s10.h,
              ),
              BlocBuilder<HomeBloc, HomeStates>(
                  // buildWhen: (previous, current) => current is GetCategoriesSuccessState ,
                  buildWhen: (previous, current) =>
                      previous.categoriesState != current.categoriesState,
                  builder: (context, state) {
                    switch (state.categoriesState) {
                      case RequestStates.loading:
                        return const ShimmerLoader();

                      case RequestStates.success:
                        return state.categoriesModel?.categoryMetaModel
                                    ?.totalLength ==
                                0
                            ? Container()
                            : CategoriesWidget(
                                categoriesModel: state.categoriesModel,
                              );
                      case RequestStates.error:
                        return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder),
                        );
                    }
                  }),
              // builder: (context, state) => state is GetCategoriesSuccessState? CategoriesWidget(categoriesModel:state.categoriesModel ):Container(),),

              SizedBox(
                height: AppSize.s24.h,
              ),
              BlocBuilder<HomeBloc, HomeStates>(
                  buildWhen: (previous, current) =>
                      previous.bestSellerState != current.bestSellerState,
                  builder: (context, state) {
                    switch (state.bestSellerState) {
                      case RequestStates.loading:
                        return const ShimmerLoader();

                      case RequestStates.success:
                        return BestSellerWidget(
                          bestSellerProductsModel: state.bestSellerModel,
                        );
                      case RequestStates.error:
                        return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder),
                        );
                    }
                  }),
              // buildWhen: (previous, current) => current is GetBestSellerSuccessState ,
              // builder: (context, state) => state is GetBestSellerSuccessState? BestSellerWidget(bestSellerProductsModel:state.bestSellerProductsModel ):Container(),),

              SizedBox(
                height: AppSize.s24.h,
              ),
              BlocBuilder<HomeBloc, HomeStates>(
                  // buildWhen: (previous, current) => current is GetNewInSuccessState ,
                  buildWhen: (previous, current) =>
                      previous.newInState != current.newInState,
                  builder: (context, state) {
                    switch (state.newInState) {
                      case RequestStates.loading:
                        return const ShimmerLoader();

                      case RequestStates.success:
                        return state.newInModel?.productMetaModel
                                    ?.totalLength ==
                                0
                            ? Container()
                            : NewSellerWidget(
                                newInProductsModel: state.newInModel);
                      case RequestStates.error:
                        return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder),
                        );
                    }
                  }),

              // builder: (context, state) => state is GetNewInSuccessState? NewSellerWidget(newInProductsModel:state.newInProductsModel ):Container( ),),

              SizedBox(
                height: AppSize.s24.h,
              ),
              BlocBuilder<HomeBloc, HomeStates>(
                  buildWhen: (previous, current) =>
                      previous.offersState != current.offersState,
                  // buildWhen: (previous, current) => current is GetOffersSuccessState ,
                  builder: (context, state) {
                    switch (state.offersState) {
                      case RequestStates.loading:
                        return const ShimmerLoader();

                      case RequestStates.success:
                        return state.offersModel?.productMetaModel
                                    ?.totalLength ==
                                0
                            ? Container()
                            : OffersWidget(
                                offersProductsModel: state.offersModel);
                      case RequestStates.error:
                        return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder),
                        );
                    }
                  }),

              // builder: (context, state) => state is GetOffersSuccessState? OffersWidget(offersProductsModel:state.offersProductsModel ):Container(),)

              SizedBox(
                height: AppSize.s24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: AppSize.s85.w,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.symmetric(horizontal: MarginValues.m16.w),
        // child: SvgPicture.asset(
        //   IconsConstants.logoIC,
        // ),
        child: ScalableImageWidget.fromSISource(
            si: ScalableImageSource.fromSvgHttpUrl(
                Uri.parse(sl<UserPreferenceRepo>().getAppLogo()))),

        // child: Image.network(
        //   // sl<UserPreferenceRepo>().getAppLogo(),
        //   "https://www.leapkw.online/Untitled-1-1693646378131.svg",
        //
        //   // placeholderBuilder: (context) =>  SvgPicture.asset(IconsConstants.placeholder),
        // ),
        // child: SvgPicture.network(
        //   "https://www.leapkw.online/Untitled-1-1693646378131.svg",
        //
        //   errorBuilder: (context, error, stackTrace) => SvgPicture.asset(IconsConstants.placeholder),
        // ),
      ),
      titleSpacing: 0,
      title: const Row(
        children: [
          Expanded(
              child: Center(
            child: AddressSelectionWidget(
              backgroundColor: Colors.transparent,
            ),
          )),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            if (context.locale == const Locale("en", "US")) {
              context.setLocale(const Locale("ar", "EG"));
              sl<UserPreferenceRepo>()
                  .insertLanguage(value: LanguageType.arabic.getValue());
            } else {
              context.setLocale(const Locale("en", "US"));
              sl<UserPreferenceRepo>()
                  .insertLanguage(value: LanguageType.english.getValue());
            }
          },
          child: Container(
              height: 40.h,
              width: 40.w,
              margin: EdgeInsets.symmetric(horizontal: MarginValues.m16.w),
              decoration: BoxDecoration(
                  color: ColorsConstants.lightBlue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(AppSize.s5.r)),
              child: Text(
                StringsConstants.lang.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontSize.s24, fontFamily: "Inter"),
                textAlign: TextAlign.center,
              )),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
