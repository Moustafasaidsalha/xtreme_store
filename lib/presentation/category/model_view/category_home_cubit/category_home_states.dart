import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/brand.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

// abstract class CategoryHomeStates extends Equatable {
//   @override
//   List<Object> get props => [];}
// class InitialState extends CategoryHomeStates{}
// // class GetCategoriesLoadingState extends CategoryHomeStates{}
// // class GetCategoriesErrorState extends CategoryHomeStates{}
// // class GetCategoriesSuccessState extends CategoryHomeStates {
// //   final   CategoriesModel? categoriesModel;
// //
// //   GetCategoriesSuccessState({
// //     required    this.categoriesModel,
// //   });
// // }
// // class GetSubCategoriesLoadingState extends CategoryHomeStates{}
// // class GetSubCategoriesErrorState extends CategoryHomeStates{}
// // class GetSubCategoriesSuccessState extends CategoryHomeStates {
// //   final   SubCategoriesModel? subCategoriesModel;
// //
// //   GetSubCategoriesSuccessState({
// //     required    this.subCategoriesModel,
// //   });
// // }
// class GetCategoryWithSubLoadingState extends CategoryHomeStates{}
// class GetCategoryWithSubErrorState extends CategoryHomeStates{}
// class GetCategoryWithSubSuccessState extends CategoryHomeStates {
//   final   CategoriesWithSubsModel? categoriesWithSubsModel;
//
//   GetCategoryWithSubSuccessState({
//     required    this.categoriesWithSubsModel,
//   });
// }
class CategoryHomeStates extends Equatable {
  final RequestStates getSubCategoriesOfCategoryState;
  final RequestStates getBrandsState;
  final RequestStates getCategoriesState;
  final List<SubCategoryModel>? subCategories;
  final List<CategoryModel>? categories;

  final BrandsModel? brandsModel;
  CategoryHomeStates copyWith({
     RequestStates? getSubCategoriesOfCategoryState,
     RequestStates? getBrandsState,
     RequestStates? getCategories,
     List<SubCategoryModel>? subCategories,
     List<CategoryModel>? categories,
    BrandsModel? brandsModel
}){
    return CategoryHomeStates(getBrandsState: getBrandsState??this.getBrandsState,brandsModel: brandsModel??this.brandsModel,categories: categories??this.categories,getCategoriesState: getCategories??this.getCategoriesState,getSubCategoriesOfCategoryState:getSubCategoriesOfCategoryState??this.getSubCategoriesOfCategoryState ,subCategories: subCategories??this.subCategories,);
}

  @override
  List<Object?> get props =>
      [
        getSubCategoriesOfCategoryState,
        getBrandsState,
        getCategoriesState,
        subCategories,
        categories,
        brandsModel,
      ];

  const CategoryHomeStates({
     this.getSubCategoriesOfCategoryState=RequestStates.loading,
     this.getBrandsState=RequestStates.loading,
     this.getCategoriesState=RequestStates.loading,
    this.subCategories,
    this.categories,
    this.brandsModel,
  });
}