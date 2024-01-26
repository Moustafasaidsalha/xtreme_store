// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:extreme_store/app/failure/failure.dart';
// import 'package:extreme_store/data/models/product.dart';
// import 'package:extreme_store/domain/uses_cases/get_products.dart';
// import 'package:extreme_store/presentation/offers/model_view/offers_states.dart';
//
// class OffersCubit extends Cubit<OffersStates> {
//   OffersCubit(this.getProductsUseCase) : super(InitialState());
//   static OffersCubit get(context) => BlocProvider.of(context);
//   GetProductsUseCase getProductsUseCase;
//
//   // Future<void> getProducts() async {
//   //   emit(GetOffersLoadingState());
//   //   var response =
//   //   await getProductsUseCase.call(const GetProductsParams(offset: 0, limit: 10, bestSeller: false, newIn: false, offer: true));
//   //   response.fold((l) {ServerFailure(l.message);
//   //   emit(GetOffersErrorState());
//   //
//   //   } , (r) {
//   //     emit(GetOffersSuccessState(offersProductsModel: r));
//   //
//   //   });
//   // }
//
//   int offset = 0;
//   int total = 0;
//   bool isMoreLoading = false;
//   List<ProductModel> p = [];
//
//   Future<void> getProducts() async {
//     print("called");
//     if (state is InitialState) {
//       emit(GetOffersLoadingState());
//     } else if (offset < total) {
//       isMoreLoading = true;
//     }
//     final res = await getProductsUseCase(
//       GetProductsParams(
//         offset: offset.toDouble(),
//         limit: 6,
//         bestSeller: false,
//         newIn: false,
//         offer: false,
//       ),
//     );
//
//     res.fold((l) {
//       emit(GetOffersErrorState());
//       isMoreLoading = false;
//     }, (r) {
//       isMoreLoading = false;
//       total = (r.productMetaModel?.totalLength ?? 0).toInt();
//       offset = r.productMetaModel?.products?.length ?? 0;
//       print("emited");
//       emit(GetOffersSuccessState(
//         offersProductsModel: p..addAll(r.productMetaModel?.products ?? []),
//       ));
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:extreme_store/app/enums/state_status.dart';
import 'package:extreme_store/presentation/offers/model_view/offer_events.dart';
import 'package:extreme_store/presentation/offers/model_view/offers_states.dart';

import '../../../domain/uses_cases/cart/add_to_cart.dart';
import '../../../domain/uses_cases/get_products.dart';

// const _postLimit = 20;
// const throttleDuration = Duration(milliseconds: 100);

// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return droppable<E>().call(events.throttle(duration), mapper);
//   };
// }

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc({required this.getProductsUseCase,required this.addToCart}) : super(const OffersState()) {
    on<OffersFetched>(
      _onOffersFetched,
      transformer: droppable(),
    );
  }
  GetProductsUseCase getProductsUseCase;
  AddToCart addToCart;

  Future<void> _onOffersFetched(
    OffersFetched event,
    Emitter<OffersState> emit,
  ) async {
    if (state.hasReachedMax) return;

    if (state.status == StateStatus.initial) {
      final res = await getProductsUseCase(
        const GetProductsParams(
          offset: 0,
          limit: 6,
          bestSeller: false,
          newIn: false,
          offer: true,
        ),
      );
      return res.fold(
          (l) => emit(state.copyWith(status: StateStatus.failure)),
          (r) => emit(
                state.copyWith(
                  status: StateStatus.success,
                  products: r.productMetaModel?.products ?? [],
                  hasReachedMax: false,
                ),
              ));
    }
    final res = await getProductsUseCase(
      GetProductsParams(
        offset: state.products.length,
        limit: 6,
        bestSeller: false,
        newIn: false,
        offer: true,
      ),
    );
    res.fold(
        (l) => emit(state.copyWith(status: StateStatus.failure)),
        (r) => (r.productMetaModel?.products?.isNotEmpty ?? false)
            ? emit(
                state.copyWith(
                  status: StateStatus.success,
                  products: List.of(state.products)..addAll(r.productMetaModel?.products ?? []),
                  hasReachedMax: false,
                ),
              )
            : emit(state.copyWith(hasReachedMax: true)));
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
