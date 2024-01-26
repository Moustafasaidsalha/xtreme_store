import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_to_cart.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/presentation/best_seller/model_view/best_seller_states.dart';

class BestSellerCubit extends Cubit<BestSellerStates> {
  BestSellerCubit(this.getProductsUseCase,this.addToCart) : super(InitialState());
  static BestSellerCubit get(context) => BlocProvider.of(context);
  GetProductsUseCase getProductsUseCase;
  final AddToCart addToCart;
  List<ProductModel>? products;
  Future<void> getProducts({required int page, required int limit}) async {
    emit(GetBestSellerLoadingState());
    var response =
    await getProductsUseCase( GetProductsParams(offset: page, limit: limit, bestSeller: true, newIn: false, offer: false));
    response.fold((l) {
      ServerFailure(l.message);
      emit(GetBestSellerErrorState());

    } , (r) {
      emit(GetBestSellerSuccessState(bestSellerProductsModel:r ));

    });
  }
  int page=0;
  int limit=20;
  bool isFirstLoadRunning=false;
  bool hasNextPage=false;
  bool isLoadMoreRunning=false;
  void firstLoad()async{
     isFirstLoadRunning=true;
     emit(GetBestSellerLoadingState());
     var response =
     await getProductsUseCase( GetProductsParams(offset: page, limit: limit, bestSeller: true, newIn: false, offer: false));
     response.fold((l) {
       ServerFailure(l.message);
       emit(GetBestSellerErrorState());

     } , (r) {
       isFirstLoadRunning=false;
       products=r.productMetaModel!.products!;
       // after add all to list assert it to the list in the state
       emit(GetBestSellerSuccessState(bestSellerProductsModel: r));

     });


  }
  void loadMore()async{
    if(hasNextPage==true&&isFirstLoadRunning==false&&isLoadMoreRunning==false){
      isLoadMoreRunning=true;

      emit(GetBestSellerLoadingState());
      page+=1;

      var response =
      await getProductsUseCase( GetProductsParams(offset: page, limit: limit, bestSeller: true, newIn: false, offer: false));
      response.fold((l) {
        ServerFailure(l.message);
        emit(GetBestSellerErrorState());

      } , (r) {
        if(r.productMetaModel!.products!.isNotEmpty) {
          products!.addAll(r.productMetaModel!.products!);

          emit(GetBestSellerSuccessState(bestSellerProductsModel: r));
        }else{
          isLoadMoreRunning=false;

        }
      });



    }
  }

  // Future<void> addProductToCart({required ProductModel productModel}) async {
  //   final res = await addToCart(AddToCartParams(productModel: productModel));
  //   res.fold((l) {
  //     if (kDebugMode) {
  //       print(l);
  //     }
  //   }, (r) {
  //     if (kDebugMode) {
  //       print(r);
  //     }
  //   });
  // }

}
