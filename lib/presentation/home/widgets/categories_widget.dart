import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/presentation/home/widgets/category_group_widget.dart';
import 'package:extreme_store/presentation/home/widgets/card_title_widget.dart';
import 'package:extreme_store/presentation/layout/model_view/layout_cubit.dart';


class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    required this.categoriesModel,
    super.key,
  });

  final CategoriesModel? categoriesModel;


  @override
  Widget build(BuildContext context) {
    var isAr = context.locale == const Locale("ar", "EG");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitleWidget(
          text: StringsConstants.categories.tr(),
          onPressed: () {
            LayoutCubit.get(context).changeBottomNav(value: 1, context: context);
            // Navigator.of(context).pushNamed(RoutesConstant.categories,arguments: [categoriesModel?.categoryMetaModel?.categories?[0].id,null,null]);
          },
        ),
        SizedBox(
          height: 11.h,
        ),
        SizedBox(
            height: 85.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutesConstant.categories,arguments: [categoriesModel?.categoryMetaModel?.categories?[index].id,null,null]);

                    },
                    child: CategoryGroupWidget(
                        categoryImage: categoriesModel?.categoryMetaModel?.categories?[index].image??"",
                        categoryName: isAr
                            ? categoriesModel?.categoryMetaModel?.categories![index].nameAr??"": categoriesModel?.categoryMetaModel?.categories?[index].nameEN??""),
                  ),
              separatorBuilder: (context, index) =>
              const SizedBox(
                width: 9,
              ),
              itemCount: categoriesModel?.categoryMetaModel?.categories?.length??0,
            )
        ),
      ],
    );
  }
}
