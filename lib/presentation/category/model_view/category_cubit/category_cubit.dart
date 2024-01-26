import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/presentation/category/model_view/category_cubit/category_states.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';
class CategoryCubit extends Cubit<CategoryStates>{
  CategoryCubit(this.getProductsUseCase):super(const CategoryStates());
  static CategoryCubit get(context)=>BlocProvider.of(context);
  GetProductsUseCase getProductsUseCase;
  Future<void> getNewInProducts(int? categoryId, int? subCategoryId,int? brandId) async {

    emit(state.copyWith(getNewInState: RequestStates.loading));
    var response =
    await getProductsUseCase( GetProductsParams(offset: 0, limit: 10, bestSeller: true, newIn: false, offer: false,categoryId:categoryId,subCategoryId:subCategoryId ,brandId:brandId  ));
    response.fold((l) {ServerFailure(l.message);
    emit(state.copyWith(getNewInState: RequestStates.error));

    } , (r) {
      emit(state.copyWith(getNewInState: RequestStates.success,newInProductsModel: r));

    });
  }
  Future<void> getOffersProducts(int? categoryId, int? subCategoryId,int? brandId) async {
    emit(state.copyWith(getOffersState: RequestStates.loading));

    var response =
    await getProductsUseCase( GetProductsParams(offset: 0, limit: 10, bestSeller: false, newIn: false, offer: true,categoryId:categoryId,subCategoryId: subCategoryId,brandId: brandId ));
    response.fold((l) {ServerFailure(l.message);
    emit(state.copyWith(getOffersState: RequestStates.error));

    } , (r) {
      emit(state.copyWith(getOffersState: RequestStates.success,offersProductsModel: r));

    });
  }
  Future<void> getBestSellerProducts( int? categoryId, int? subCategoryId,int? brandId ) async {
    emit(state.copyWith(getBestSellerState: RequestStates.loading));

    var response =
    await getProductsUseCase( GetProductsParams(offset: 0, limit: 10, bestSeller: true, newIn: false, offer: false,categoryId: categoryId,subCategoryId:subCategoryId ,brandId:brandId ));
    response.fold((l) {ServerFailure(l.message);
    emit(state.copyWith(getBestSellerState: RequestStates.error));

    } , (r) {
      emit(state.copyWith(getBestSellerState: RequestStates.success,bestSellerProductsModel: r));

    });
  }
}