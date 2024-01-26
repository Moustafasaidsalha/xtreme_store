import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extreme_store/app/constants/colors_constants.dart';
import 'package:extreme_store/app/constants/fonts_constants.dart';
import 'package:extreme_store/app/constants/icon_constants.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/presentation/common_widgets/buttons/reusable_elevated_button.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/search/model_view/search_cubit.dart';
import 'package:extreme_store/presentation/search/model_view/search_states.dart';


class FilterWidget extends StatefulWidget {
   FilterWidget({
    super.key,
    required this.sortById,
    required this.categoryId,
    required this.subCategoryId,
  });
  int? subCategoryId;
  int? categoryId;
  String? sortById;
  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  @override
  void initState() {
    super.initState();
    SearchCubit.get(context).getCategories();
  }
  @override
  Widget build(BuildContext context) {

    var isAr = context.locale == const Locale("ar", "EG");
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 22.h, left: 19.w),
        margin: EdgeInsets.symmetric(horizontal: 19.w,),

        // width: 390.w,
        height: 600.h,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsConstants.filter.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19.w),
                    child: SvgPicture.asset(IconsConstants.closeCircleIC,colorFilter: ColorFilter.mode(ColorsConstants.iconsColor, BlendMode.srcIn)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(StringsConstants.category.tr(),
                style: Theme.of(context).textTheme.titleSmall),
            SizedBox(
              height: 15.h,
            ),
            BlocBuilder<SearchCubit, SearchStates>(
            builder: (context, state) {
              switch(state.categoriesState){
                case  RequestStates.loading:
                  return Container();
                case  RequestStates.success:
                  return SizedBox(
                    height: 25.h,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>  GestureDetector(
                            onTap: () {
                              SearchCubit.get(context).changeCategory(index);
                              widget.categoryId=state.categories?[index].id;

                              SearchCubit.get(context).getSubCategories(state.categories?[index].id??0);
                            },
                            child: CategoryFilterItemWidget(
                                selectedCategories: SearchCubit.get(context).selectedCategory[index],

                                categoryName: isAr?state.categories![index].nameAr??"":state.categories?[index].nameEN??"")),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 11.w,
                        ),
                        itemCount: state.categories?.length??0),
                  );
                case RequestStates.error:
                  return Container();
              }
            },
),
            SizedBox(
              height: 24.h,
            ),

            BlocBuilder<SearchCubit, SearchStates>(
  builder: (context, state) {
    switch(state.subCategoriesState){
      case  RequestStates.loading:
        return Container();
      case  RequestStates.success:
        return state.subCategories!.isEmpty? Container(): Column(
          children: [
            Text(
              StringsConstants.subCategory.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 25.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          SearchCubit.get(context).changeSubCategory(index);

                          widget.subCategoryId=state.subCategories?[index].id;
setState(() {

});
                        },
                        child:  SubCategoryItemWidget(

                            isSelected: SearchCubit.get(context).selectedSubCategory[index],
                            subCategoryName: isAr?state.subCategories![index].nameAr??"":state.subCategories?[index].nameEN??""));


                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 11.w,
                  ),
                  itemCount: state.subCategories?.length??0),
            ),
          ],
        );
      case RequestStates.error:
        return Container();
    }
  },
),
            SizedBox(
              height: 24.h,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                StringsConstants.sortBy.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 10.h,
              ),
              Wrap(
                // runSpacing: 10.h,
                children: List.generate(
                    SearchCubit.get(context).sortBy.length,
                        (index) =>  GestureDetector(
                            onTap: () {
                              SearchCubit.get(context).changeOrderedBy(index);
                              widget.sortById=SearchCubit.get(context).sortBy[index];
setState(() {

});
                            },
                            child: SortByItemWidget(
                              isSelected: SearchCubit.get(context).orderedBy[index],
                              sortByName: SearchCubit.get(context).sortBy[index].tr(),))),
              ),
            ]),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 19.w),
                      child: ReusableElevatedButton(
                        title: StringsConstants.apply.tr(),
                        onPressed: () {

                          SearchCubit.get(context).searchProducts(sortById: widget.sortById,categoryId: widget.categoryId,subCategoryId:widget.subCategoryId );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // MainButton(margin: 24.w, height: 58.h, radius: 10.r, onPressed: (){}, color: ColorsConstants.black, text: StringsConstants.apply, textStyle: const TextStyle())
          ],
        ),
      ),
    );
  }
}

class SortByItemWidget extends StatelessWidget {
  const SortByItemWidget({
    super.key,
    required this.sortByName,
    required this.isSelected
  });
final String sortByName;
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 39.h,
        margin: EdgeInsets.only(top: 12.h, right: 12.w),
        padding: EdgeInsets.symmetric(
            vertical: 10.h, horizontal: 15.w),
        decoration: ShapeDecoration(
          color: isSelected?ColorsConstants.semiBlack:ColorsConstants.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50.w,
                color: ColorsConstants.semiBlack),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          sortByName,
          style:
          Theme.of(context).textTheme.titleSmall!.copyWith(
            color: isSelected?ColorsConstants.white:ColorsConstants.black,
            fontSize: FontSize.s14,
          ),
        ));
  }
}

class SubCategoryItemWidget extends StatefulWidget {
  const SubCategoryItemWidget({
    super.key,
    required this.subCategoryName,
    required this.isSelected,
  });
  final String subCategoryName;
final bool isSelected;

  @override
  State<SubCategoryItemWidget> createState() => _SubCategoryItemWidgetState();
}

class _SubCategoryItemWidgetState extends State<SubCategoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: widget.isSelected?ColorsConstants.semiBlack:ColorsConstants.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r)),
      ),
      height: 25.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15.w, vertical: 10.h),
        child: Text(
          widget.subCategoryName,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(
              color: widget.isSelected?ColorsConstants.white:ColorsConstants.black, height: .3),
          textAlign: TextAlign.center,
          textHeightBehavior: const TextHeightBehavior(
              applyHeightToLastDescent: true),
        ),
      ),
    );
  }

}

class CategoryFilterItemWidget extends StatelessWidget {
  const CategoryFilterItemWidget({
    super.key,
    required this.categoryName,
    required this.selectedCategories
  });
final String categoryName;
  final bool selectedCategories;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: selectedCategories?ColorsConstants.semiBlack:ColorsConstants.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r)),
      ),
      height: 25.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15.w, vertical: 10.h),
        child: Text(
          categoryName,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(
              color: selectedCategories?ColorsConstants.white:ColorsConstants.black, height: .3),
          textAlign: TextAlign.center,
          textHeightBehavior: const TextHeightBehavior(
              applyHeightToLastDescent: true),
        ),
      ),
    );
  }

}