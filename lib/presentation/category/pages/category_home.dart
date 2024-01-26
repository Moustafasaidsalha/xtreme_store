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
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/presentation/category/model_view/category_home_cubit/category_home_cubit.dart';
import 'package:extreme_store/presentation/category/model_view/category_home_cubit/category_home_states.dart';
import 'package:extreme_store/presentation/category/pages/category.dart';
import 'package:extreme_store/presentation/home/model_view/home_bloc.dart';
import 'package:extreme_store/presentation/home/widgets/category_group_widget.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:shimmer/shimmer.dart';

class CategoryHomeScreen extends StatefulWidget {
  const CategoryHomeScreen({Key? key}) : super(key: key);

  @override
  State<CategoryHomeScreen> createState() => _CategoryHomeScreenState();
}

class _CategoryHomeScreenState extends State<CategoryHomeScreen> {
  @override
  void initState() {
    super.initState();

    // CategoryHomeBloc.get(context)..add(GetCategoriesWithSubsEvent())..add(GetBrandsEvent());
    CategoryHomeCubit.get(context)
      ..getCategories()
      ..getBrands()
      ..getSubCategoriesOfCategory(HomeBloc.get(context).categoryId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale == const Locale("ar", "EG");

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          StringsConstants.categories.tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingValues.p16.w, vertical: PaddingValues.p24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 85.h,
                  child: BlocBuilder<CategoryHomeCubit, CategoryHomeStates>(
                    buildWhen: (previous, current) =>
                        previous.getCategoriesState !=
                        current.getCategoriesState,
                    builder: (context, state) {
                      switch (state.getCategoriesState) {
                        case RequestStates.loading:
                          return const ShimmerLoader();

                        case RequestStates.success:
                          return ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      CategoryHomeCubit.get(context)
                                        ..getSubCategoriesOfCategory(
                                            state.categories?[index].id ?? 0);
                                    },
                                    child: CategoryGroupWidget(
                                        categoryImage:
                                            state.categories?[index].image ??
                                                "",
                                        categoryName: isAr
                                            ? state.categories![index].nameAr ??
                                                ""
                                            : state.categories?[index].nameEN ??
                                                ""),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 9.w,
                                  ),
                              itemCount: state.categories?.length ?? 0);
                        case RequestStates.error:
                          return Container(
                            child: SvgPicture.asset(IconsConstants.placeholder),
                          );
                      }
                      // return state is GetCategoryWithSubSuccessState? ListView.separated(
                      //
                      //             shrinkWrap: true,
                      //             scrollDirection: Axis.horizontal,
                      //             itemBuilder: (context, index) => CategoryGroupWidget(categoryImage:state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?[index].image??"" ,categoryName:isAr?state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel![index].nameAr??"":state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?[index].nameEN??"" ) , separatorBuilder: (context, index) => SizedBox(width: 9.w,), itemCount: state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?.length??0):Container();
                    },
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                // CategoriesWidgets(categoryTitle: ,subs: []),
                SizedBox(
                  height: 31.h,
                ),
//         BlocBuilder<CategoryHomeCubit, CategoryHomeStates>(
//           buildWhen: (previous, current) =>  current is GetCategoryWithSubSuccessState,
//   builder: (context, state) {
//     return state is GetCategoriesSuccessState?Column(
//           children: [
//             Row(
//               children: [
//                 Text(state.categoriesModel.categoryMetaModel.categories[index].nameAr,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsConstants.black3),),
//               ],
//             ),
//
//             SizedBox(height: 16.h,),
//             SizedBox(
//               height: 120.h,
//               child: ListView.separated(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//
//                   itemBuilder: (context, index) =>   CategoryItemWidget(subCategoryImage:state.categoriesModel!.categoryMetaModel!.categories![index].image!,subCategoryName: isAr?state.categoriesModel!.categoryMetaModel!.categories![index].nameAr!:state.categoriesModel!.categoryMetaModel!.categories![index].nameEN!, ), separatorBuilder: (context, index) => SizedBox(width: 30.w,), itemCount: state.categoriesModel!.categoryMetaModel!.categories!.length),
//             ),
//           ],
//         ):Container();
//   },
// ),
                SizedBox(
                  height: 25.h,
                ),
                BlocBuilder<CategoryHomeCubit, CategoryHomeStates>(
                  buildWhen: (previous, current) =>
                      previous.getBrandsState != current.getBrandsState,
                  builder: (context, state) {
                    switch (state.getBrandsState) {
                      case RequestStates.loading:
                        return const ShimmerLoader();

                      case RequestStates.success:
                        return state.brandsModel?.brandsMetaModel
                                    ?.totalLength ==
                                0
                            ? Container()
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        StringsConstants.topBrands.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: ColorsConstants.black3),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    height: 120.h,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    RoutesConstant.categories,
                                                    arguments: [
                                                      null,
                                                      null,
                                                      state
                                                              .brandsModel
                                                              ?.brandsMetaModel
                                                              ?.brands?[index]
                                                              .id ??
                                                          0
                                                    ]);
                                              },
                                              child: CategoryItemWidget(
                                                subCategoryImage: state
                                                        .brandsModel
                                                        ?.brandsMetaModel
                                                        ?.brands?[index]
                                                        .image ??
                                                    "",
                                                subCategoryName: isAr
                                                    ? state
                                                            .brandsModel
                                                            ?.brandsMetaModel
                                                            ?.brands![index]
                                                            .nameAr ??
                                                        ""
                                                    : state
                                                            .brandsModel
                                                            ?.brandsMetaModel
                                                            ?.brands?[index]
                                                            .nameEn ??
                                                        "",
                                              ),
                                            ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 9.w,
                                            ),
                                        itemCount: state
                                                .brandsModel
                                                ?.brandsMetaModel
                                                ?.brands
                                                ?.length ??
                                            0),
                                  )
                                ],
                              );
                      case RequestStates.error:
                        return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder),
                        );
                    }
                    // return state is GetCategoryWithSubSuccessState? ListView.separated(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemBuilder:(context, index) =>  CategoriesWidgets(subs: state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel![index].subs??[],categoryTitle: isAr? state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel![index].nameAr??"":state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?[index].nameEN??""), separatorBuilder: (context, index) => SizedBox(height: 20,), itemCount: state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?.length??0):Container();
                  },
                ),

                SizedBox(
                  height: 25.h,
                ),

                BlocBuilder<CategoryHomeCubit, CategoryHomeStates>(
                  buildWhen: (previous, current) =>
                      previous.getSubCategoriesOfCategoryState !=
                      current.getSubCategoriesOfCategoryState,
                  builder: (context, state) {
                    switch (state.getSubCategoriesOfCategoryState) {
                      case RequestStates.loading:
                        return const ShimmerLoader();

                      case RequestStates.success:
                        return (state.subCategories!.isEmpty)
                            ? Container(
                                // child: Text(StringsConstants.noSubs.tr(),style: Theme.of(context).textTheme.titleMedium,),
                                child: NoProductsInCategoryWidget(
                                    title: StringsConstants.noSubs.tr()),
                              )
                            : CategoriesWidgets(
                                subs: state.subCategories ?? [],
                                categoryTitle: isAr
                                    ? (state.subCategories?[0].category
                                            ?.nameAr ??
                                        "")
                                    : state.subCategories?[0].category
                                            ?.nameEN ??
                                        "");
                      case RequestStates.error:
                        return Container(
                          child: SvgPicture.asset(IconsConstants.placeholder),
                        );
                    }
                    // return state is GetCategoryWithSubSuccessState? ListView.separated(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemBuilder:(context, index) =>  CategoriesWidgets(subs: state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel![index].subs??[],categoryTitle: isAr? state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel![index].nameAr??"":state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?[index].nameEN??""), separatorBuilder: (context, index) => SizedBox(height: 20,), itemCount: state.categoriesWithSubsModel?.categoriesWithSubsMetaModel?.categoriesWithSubsDataModel?.length??0):Container();
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const LoaderWidget());
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 345.w,
      height: 248.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 6.h, left: 12.w),
            width: 118.w,
            height: 14.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFEDF3F6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.only(top: 6.h, left: 12.w),
            width: 190.w,
            height: 14.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFEDF3F6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r)),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: 294.25.w,
            height: 60.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFEDF3F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 21.w,
                height: 21.h,
                decoration: const ShapeDecoration(
                  color: Color(0xFFEDF3F6),
                  shape: OvalBorder(),
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46.w,
                    height: 14.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDF3F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 246.w,
                    height: 14.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDF3F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 21.w,
                height: 21.h,
                decoration: const ShapeDecoration(
                  color: Color(0xFFEDF3F6),
                  shape: OvalBorder(),
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46.w,
                    height: 14.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDF3F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 246.w,
                    height: 14.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDF3F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CategoriesWidgets extends StatelessWidget {
  const CategoriesWidgets({
    required this.subs,
    required this.categoryTitle,
    super.key,
  });

  final String categoryTitle;

  final List<SubCategoryModel> subs;

  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Column(
      children: [
        Row(
          children: [
            Text(
              categoryTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorsConstants.black3),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        GridView.builder(
          itemCount: subs.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RoutesConstant.categories,
                  arguments: [null, subs[index].id, null]);
            },
            child: CategoryItemWidget(
              subCategoryImage: subs[index].image!,
              subCategoryName:
                  isAr ? subs[index].nameAr ?? "" : subs[index].nameEN ?? "",
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 24.h,
            // crossAxisSpacing: 10.w,
            // childAspectRatio: .8.h,

            crossAxisCount: 3,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    required this.subCategoryImage,
    required this.subCategoryName,
    super.key,
  });

  final String subCategoryName;
  final String subCategoryImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: ColorsConstants.lightBlue,
          height: 86.h,
          width: 101.w,
          child: Image.network(
            subCategoryImage,
            errorBuilder: (context, error, stackTrace) => Container(
              child: SvgPicture.asset(IconsConstants.placeholder),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          subCategoryName,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: ColorsConstants.lightGrey,
              fontSize: FontSize.s10.sp,
              overflow: TextOverflow.ellipsis),
        )
      ],
    );
  }
}
