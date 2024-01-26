import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

class SearchStates extends Equatable {
  final RequestStates searchState;
  final RequestStates categoriesState;
  final RequestStates subCategoriesState;
  final List<SubCategoryModel>? subCategories;
  final RequestStates changeSubs;

  final List<ProductModel>? products;
  final List<CategoryModel>? categories;

  SearchStates copyWith({
    RequestStates? searchState,
    RequestStates? categoriesState,
    RequestStates? changeSubs,
    RequestStates? subCategoriesState,
    List<SubCategoryModel>? subCategories,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
  }) {
    return SearchStates(
      products: products ?? this.products,
      changeSubs: changeSubs ?? this.changeSubs,
      searchState: searchState ?? this.searchState,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      categoriesState: categoriesState ?? this.categoriesState,
      subCategoriesState: subCategoriesState ?? this.subCategoriesState,
    );
  }

  @override
  List<Object?> get props => [
        searchState,
        categoriesState,
        subCategoriesState,
        subCategories,
        products,
        categories,
    changeSubs,
      ];

  const SearchStates({
    this.searchState = RequestStates.loading,
    this.changeSubs = RequestStates.loading,
    this.categoriesState = RequestStates.loading,
    this.subCategoriesState = RequestStates.loading,
    this.subCategories,
    this.products,
    this.categories,
  });
}
