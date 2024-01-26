import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/domain/uses_cases/get_banners.dart';
import 'package:extreme_store/domain/uses_cases/get_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_variants.dart';
import 'package:extreme_store/presentation/home/model_view/home_event.dart';
import 'package:extreme_store/presentation/home/model_view/home_states.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_states.dart';

import '../../../app/di/injection_container.dart';
import '../../../app/use_case/use_case.dart';
import '../../../domain/repositories/user_preference_repo.dart';
import '../../../domain/uses_cases/cart/add_to_cart.dart';
import '../../../domain/uses_cases/get_app_theme.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc(
    this.getProductsUseCase,
    this.getCategoriesUseCase,
    this.getBannersUseCase,
    this.getSubCategoriesUseCase,
    this.getVariantsUseCase,
    this.getAppThemeUseCase,
    this.addToCart,
  ) : super(const HomeStates()) {
    on<GetBannersEvent>(getBanners);
    on<GetCategoriesEvent>(getCategories);
    on<GetNewInEvent>(getNewInProducts);
    on<GetBestSellerEvent>(getBestSellerProducts);
    on<GetOffersEvent>(getOfferProducts);
  }
  GetCategoriesUseCase getCategoriesUseCase;
  GetSubCategoriesUseCase getSubCategoriesUseCase;
  GetVariantsUseCase getVariantsUseCase;
  GetProductsUseCase getProductsUseCase;
  GetBannersUseCase getBannersUseCase;
  final AddToCart addToCart;
  static HomeBloc get(context) => BlocProvider.of(context);
  late Timer timer;
  int _numPages = 0;
  void startAutoScroll() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (dotIndex < _numPages - 1) {
        dotIndex++;
      } else {
        dotIndex = 0;
      }
      controller.animateToPage(
        dotIndex,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
      );
    });
  }

  PageController controller = PageController();
  int dotIndex = 0;
  changeDotIndex(int value) {
    dotIndex = value;

    controller.animateToPage(value,
        duration: const Duration(microseconds: 300), curve: Curves.easeInSine);
  }

  int? categoryId;
  FutureOr<void> getBanners(
      GetBannersEvent event, Emitter<HomeStates> emit) async {
    final result =
        await getBannersUseCase(GetBannersParams(offset: 0, limit: 10));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(bannersState: RequestStates.error));
    }, (r) {
      _numPages = r.bannerMetaModel?.totalLength ?? 0;
      emit(
          state.copyWith(bannersState: RequestStates.success, bannersModel: r));
    });
  }

  FutureOr<void> getCategories(
      GetCategoriesEvent event, Emitter<HomeStates> emit) async {
    final result =
        await getCategoriesUseCase(GetCategoriesParams(offset: 0, limit: 10));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(categoriesState: RequestStates.error));
    }, (r) {
      categoryId = r.categoryMetaModel?.categories?[0].id ?? 0;
      emit(state.copyWith(
          categoriesState: RequestStates.success, categoriesModel: r));
    });
  }

  FutureOr<void> getNewInProducts(
      GetNewInEvent event, Emitter<HomeStates> emit) async {
    final result = await getProductsUseCase(const GetProductsParams(
        offset: 0, limit: 10, bestSeller: false, newIn: true, offer: false));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(newInState: RequestStates.error));
    },
        (r) => emit(
            state.copyWith(newInState: RequestStates.success, newInModel: r)));
  }

  FutureOr<void> getBestSellerProducts(
      GetBestSellerEvent event, Emitter<HomeStates> emit) async {
    final result = await getProductsUseCase(const GetProductsParams(
        offset: 0, limit: 10, bestSeller: true, newIn: false, offer: false));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(bestSellerState: RequestStates.error));
    },
        (r) => emit(state.copyWith(
            bestSellerState: RequestStates.success, bestSellerModel: r)));
  }

  FutureOr<void> getOfferProducts(
      GetOffersEvent event, Emitter<HomeStates> emit) async {
    final result = await getProductsUseCase(const GetProductsParams(
        offset: 0, limit: 10, bestSeller: false, newIn: false, offer: true));
    result.fold((l) {
      ServerFailure(l.message);
      emit(state.copyWith(offersState: RequestStates.error));
    },
        (r) => emit(state.copyWith(
            offersState: RequestStates.success, offersModel: r)));
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
  GetAppThemeUseCase getAppThemeUseCase;
  Color? mainColor;
  FutureOr<void> getAppTheme() async {
    var result = await getAppThemeUseCase(NoParams());

    result.fold((l) {
      ServerFailure(l.message);
    }, (r) {
      sl<UserPreferenceRepo>()
          .insertAppLogo(value: r.appThemeDataModel?.mobileLogo ?? "");
      sl<UserPreferenceRepo>()
          .insertMainColor(value: r.appThemeDataModel?.mainColor ?? "");
      // mainColor=  r.appThemeDataModel?.mainColor??"".toColor();
      sl<UserPreferenceRepo>()
          .insertLabelColor(value: r.appThemeDataModel?.labelColor ?? "");
      // emit(state.copyWith(themeState: RequestStates.success));
    });
  }
}
