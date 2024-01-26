import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/uses_cases/get_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_category_of_category.dart';
import 'package:extreme_store/domain/uses_cases/search.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
import 'package:extreme_store/presentation/search/model_view/search_states.dart';
import 'package:extreme_store/presentation/search/widgets/filter_widget.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(this.searchUseCase, this.getSubCategoriesOfCategoryUseCase,
      this.getCategoriesUseCase)
      : super(const SearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);
  final SearchUseCase searchUseCase;

  // GetProductsUseCase getProductsUseCase;
  // Future<void> getProducts() async {
  //   emit(GetSearchLoadingState());
  //   var response =
  //   await getProductsUseCase(const GetProductsParams(offset: 0, limit: 10, bestSeller: true, newIn: true, offer: true));
  //   response.fold((l) {
  //     ServerFailure(l.message);
  //
  //     emit(GetSearchErrorState());
  //
  //   }, (r) {
  //     emit(GetSearchSuccessState(productsModel: r));
  //
  //   });
  // }
  // GetSubCategoriesUseCase getSubCategoriesUseCase;
  // GetCategoriesUseCase getCategoriesUseCase;

  searchProducts({String? name, sortById, subCategoryId, categoryId}) async {
    emit(state.copyWith(searchState: RequestStates.loading));
    final result = await searchUseCase(SearchParams(
        offset: 0,
        limit: 100,
        bestSeller: true,
        newIn: sortById == StringsConstants.newInSearch ? true : false,
        offer: sortById == StringsConstants.offerSearch ? true : false,
        name: name ?? "",
        sortBy: sortById,
        subCategoryId: subCategoryId,
        categoryId: categoryId));

    result.fold(
      (failure) {
        ServerFailure(failure.message);
        emit(state.copyWith(searchState: RequestStates.error));
      },
      (products) {
        emit(state.copyWith(
            products: products.productMetaModel?.products,
            searchState: RequestStates.success));
      },
    );
  }

  GetCategoriesUseCase getCategoriesUseCase;
  GetSubCategoriesOfCategoryUseCase getSubCategoriesOfCategoryUseCase;

  getCategories() async {
    // emit(state.copyWith(categoriesState: RequestStates.loading,categories: []));

    final result =
        await getCategoriesUseCase(GetCategoriesParams(offset: 0, limit: 100));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(categoriesState: RequestStates.error));
    }, (r) {
      // categoryId = r.categoryMetaModel?.categories?[0].id ?? 0;
// categoryLength=r.categoryMetaModel?.categories?.length??0;
      selectedCategory = List.generate(
          r.categoryMetaModel?.categories?.length ?? 0, (index) => false);

      emit(state.copyWith(
          categoriesState: RequestStates.success,
          categories: r.categoryMetaModel?.categories));
    });
  }

  getSubCategories(int categoryID) async {
    emit(state.copyWith(
        subCategoriesState: RequestStates.loading, subCategories: []));

    final result = await getSubCategoriesOfCategoryUseCase(
        GetSubCategoriesOfCategoryParams(
            offset: 0, limit: 100, categoryId: categoryID));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(subCategoriesState: RequestStates.error));
    }, (r) {
      // categoryId = r.categoryMetaModel?.categories?[0].id ?? 0;
      selectedSubCategory = List.generate(
          r.subCategoryMetaModel?.totalLength ?? 0, (index) => false);
      emit(state.copyWith(
        subCategoriesState: RequestStates.success,
        subCategories: r.subCategoryMetaModel?.subCategories,
      ));
    });
  }

  int categoryLength = 0;
  Future<dynamic> showFilter({
    required BuildContext context,
    int? subCategoryId,
    int? categoryId,
    String? sortById,
  }) {
    return showDialog(
      context: context,
      builder: (context) => FilterWidget(
          categoryId: subCategoryId,
          subCategoryId: categoryId,
          sortById: sortById),
    );
  }

  List<bool> selectedCategory = [];
  List<bool> selectedSubCategory = [];
  List<bool> orderedBy = List.generate(8, (index) => false);

  changeCategory(index) {
    // print("indexxxxx${index}");
    if (!selectedCategory[index]) {
      selectedCategory[index] = true; // Check the selected category

      // Deselect other categories
      for (int i = 0; i < selectedCategory.length; i++) {
        if (i != index) {
          selectedCategory[i] = false;
        }
      }
    }
  }

  changeSubCategory(index) {
    if (!selectedSubCategory[index]) {
      selectedSubCategory[index] = true;

      for (int i = 0; i < selectedSubCategory.length; i++) {
        if (i != index) {
          selectedSubCategory[i] = false;
        }
      }
    }
  }

  changeOrderedBy(index) {
    if (!orderedBy[index]) {
      orderedBy[index] = true;

      for (int i = 0; i < orderedBy.length; i++) {
        if (i != index) {
          orderedBy[i] = false;
        }
      }
    }
  }

  List<String> sortBy = [
    StringsConstants.offerSearch,
    StringsConstants.newestSearch,
    StringsConstants.oldestSearch,
    StringsConstants.newInSearch,
    StringsConstants.highPriceSearch,
    StringsConstants.lowPriceSearch,
    StringsConstants.aToZSearch,
    StringsConstants.zToaSearch,
  ];
}
