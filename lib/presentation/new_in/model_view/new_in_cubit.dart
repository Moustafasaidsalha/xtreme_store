import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_to_cart.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/presentation/new_in/model_view/new_in_state.dart';

class NewInCubit extends Cubit<NewInState> {
  NewInCubit({
    required this.getProductsUseCase,
    required this.addToCart,
  }) : super(const NewInState());

  static NewInCubit get(context) => BlocProvider.of(context);
  final GetProductsUseCase getProductsUseCase;
  final AddToCart addToCart;

  int total = 0;
  bool isLoadingMore = false;
  int x = 0;

  Future<void> getProducts() async {
    emit(state.copyWith(stateStatus: StateStatus.loading));
    final res = await getProductsUseCase(
      const GetProductsParams(
        offset: 0,
        limit: 8,
        bestSeller: false,
        newIn: true,
        offer: false,
      ),
    );

    res.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(stateStatus: StateStatus.failure));
    }, (r) {
      total = r.productMetaModel?.products?.length ?? 0;
      emit(state.copyWith(
        stateStatus: StateStatus.success,
        newInProducts: r.productMetaModel?.products ?? [],
        hasReachedMax: state.newInProducts.length == (r.productMetaModel?.totalLength ?? 0),
      ));
    });
  }

  Future<void> getMoreProducts() async {
    if (!state.hasReachedMax) {
      print(++x);
      isLoadingMore = true;
      final res = await getProductsUseCase(
        GetProductsParams(
          offset: state.newInProducts.length,
          limit: 8,
          bestSeller: false,
          newIn: true,
          offer: false,
        ),
      );
      res.fold((l) {
        isLoadingMore = false;

        emit(state.copyWith(stateStatus: StateStatus.failure, loadingMore: false));
      }, (r) {
        isLoadingMore = false;
        var l = List.of(state.newInProducts)..addAll(r.productMetaModel?.products ?? []);
        if (state.newInProducts.length == l.length) {
          print("last do");
        }

        emit(state.copyWith(
          stateStatus: StateStatus.success,
          newInProducts: l,
          hasReachedMax: state.newInProducts.length == l.length,
          loadingMore: false,
        ));
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

///TODO offset and limit must be int
///TODO use GridView.builder not count
///TODO do not invoke call use the use case direct
