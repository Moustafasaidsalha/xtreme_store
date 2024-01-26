
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/domain/uses_cases/get_brands.dart';
import 'package:extreme_store/domain/uses_cases/get_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_category_with_sub.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_category_of_category.dart';
import 'package:extreme_store/presentation/category/model_view/category_home_cubit/category_home_states.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
class  CategoryHomeCubit extends Cubit< CategoryHomeStates>{
   CategoryHomeCubit(this.getSubCategoriesOfCategoryUseCase,this.getBrandsUseCase,this.getSubCategoriesUseCase,this.getCategoriesUseCase,this.getCategoryWithSubsUseCase):super(CategoryHomeStates());
  static  CategoryHomeCubit get(context)=>BlocProvider.of(context);
   GetCategoriesUseCase getCategoriesUseCase;
   GetSubCategoriesUseCase getSubCategoriesUseCase;
   CategoriesModel? categoriesModel;
   SubCategoriesModel? subCategoriesModel;
   GetCategoryWithSubsUseCase getCategoryWithSubsUseCase;
   GetBrandsUseCase getBrandsUseCase;
   GetSubCategoriesOfCategoryUseCase getSubCategoriesOfCategoryUseCase;

 getCategories( ) async {
     var response =
     await getCategoriesUseCase( const GetCategoriesParams(offset: 0, limit: 10,));
     response.fold((l) {ServerFailure(l.message);

     emit(state.copyWith(getCategories: RequestStates.error));

     } , (r) {

       emit(state.copyWith(getCategories: RequestStates.success,categories: r.categoryMetaModel?.categories??[]));

     });

   }
   getSubCategoriesOfCategory(int categoryId)async{
     emit(state.copyWith(subCategories: [],getSubCategoriesOfCategoryState: RequestStates.loading));
     var response = await getSubCategoriesOfCategoryUseCase(GetSubCategoriesOfCategoryParams(offset: 0, limit: 10, categoryId: categoryId));
          response.fold((l) {ServerFailure(l.message);
     emit(state.copyWith(getSubCategoriesOfCategoryState: RequestStates.error));
     } , (r)=>emit(state.copyWith(subCategories: r.subCategoryMetaModel?.subCategories??[],getSubCategoriesOfCategoryState: RequestStates.success)));
   }
//    getCategoryWithSub ()async{
// emit(state.copyWith(getCategoriesWithSubState: RequestStates.loading));
//      var response =
//      await getCategoryWithSubsUseCase(const GetCategoryWithSubsParams(offset: 0, limit: 10));
//      response.fold((l) {ServerFailure(l.message);
//      emit(state.copyWith(getCategoriesWithSubState: RequestStates.error));
//      } , (r)=>emit(state.copyWith(categoriesWithSubsModel: r,getCategoriesWithSubState: RequestStates.success)));
//    }
   getBrands()async{
     emit(state.copyWith(getBrandsState: RequestStates.loading));

     var response =
     await getBrandsUseCase(GetBrandsParams(offset: 0, limit: 10));
     response.fold((l) {ServerFailure(l.message);
     emit(state.copyWith(getBrandsState: RequestStates.error));
     } , (r) => emit(state.copyWith(brandsModel: r,getBrandsState: RequestStates.success)));
   }

}