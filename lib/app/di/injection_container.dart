import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:extreme_store/data/data_source/firebase/firebase_auth_source.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/data_source/local/dynamic_variants_dao.dart';
import 'package:extreme_store/data/data_source/local/local_data_base.dart';
import 'package:extreme_store/data/data_source/remote/auth_data_source.dart';
import 'package:extreme_store/data/data_source/remote/data_source.dart';
import 'package:extreme_store/data/data_source/remote/google_maps_data_source.dart';
import 'package:extreme_store/data/repositories/auth_repo_impl.dart';
import 'package:extreme_store/data/repositories/repository.dart';
import 'package:extreme_store/domain/uses_cases/address/get_area.dart';
import 'package:extreme_store/domain/uses_cases/cart/add_to_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/change_product_cart_amount.dart';
import 'package:extreme_store/domain/uses_cases/cart/delete_from_cart.dart';
import 'package:extreme_store/domain/uses_cases/cart/get_cart_products.dart';
import 'package:extreme_store/domain/uses_cases/cart/migrate_local_cart_t_online.dart';
import 'package:extreme_store/domain/uses_cases/delete_wishlist_item.dart';
import 'package:extreme_store/domain/uses_cases/address/get_addresses.dart';
import 'package:extreme_store/domain/uses_cases/get_ad_screen.dart';
import 'package:extreme_store/domain/uses_cases/get_app_theme.dart';
import 'package:extreme_store/domain/uses_cases/get_banners.dart';
import 'package:extreme_store/domain/uses_cases/get_brands.dart';
import 'package:extreme_store/domain/uses_cases/get_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_category_with_sub.dart';
import 'package:extreme_store/domain/uses_cases/get_change_of_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_dynamic_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_orders.dart';
import 'package:extreme_store/domain/uses_cases/get_orders_by_id.dart';
import 'package:extreme_store/domain/uses_cases/get_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_category_of_category.dart';
import 'package:extreme_store/domain/uses_cases/notify_me.dart';
import 'package:extreme_store/domain/uses_cases/order/order_summary.dart';
import 'package:extreme_store/domain/uses_cases/profile/get_profile.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_wishlists.dart';
import 'package:extreme_store/data/repositories/user_preference_repo_impl.dart';
import 'package:extreme_store/domain/repositories/auth_repo.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/profile/get_settings.dart';
import 'package:extreme_store/domain/uses_cases/search.dart';
import 'package:extreme_store/domain/uses_cases/set_wishlist_item.dart';
import 'package:extreme_store/domain/uses_cases/time_slot/get_block_date.dart';
import 'package:extreme_store/presentation/ad_screen/model_view/ad_screen_cubit.dart';
import 'package:extreme_store/presentation/cart/model_view/cart_cubit.dart';
import 'package:extreme_store/presentation/category/model_view/category_cubit/category_cubit.dart';
import 'package:extreme_store/presentation/category/model_view/category_home_cubit/category_home_cubit.dart';
import 'package:extreme_store/presentation/home/model_view/home_bloc.dart';
import 'package:extreme_store/presentation/layout/model_view/layout_cubit.dart';
import 'package:extreme_store/presentation/my_account/model_view/account_cubit.dart';
import 'package:extreme_store/presentation/order_lookup/model_view/order_lookup_cubit.dart';
import 'package:extreme_store/presentation/orders/model_view/orders_cubit.dart';
import 'package:extreme_store/presentation/product_details/model_view/product_details_bloc.dart';
import 'package:extreme_store/presentation/search/model_view/search_cubit.dart';
import 'package:extreme_store/presentation/track_order/model_view/track_order_cubit.dart';
import 'package:extreme_store/presentation/wishlist/model_view/wish_list_cubit.dart';

import '../../data/data_source/local/user_preference_source.dart';
import '../../domain/repositories/base_repository.dart';
import '../../domain/uses_cases/cancel_order.dart';
import '../../domain/uses_cases/cart/add_promo_code.dart';
import '../../domain/uses_cases/cart/remove_promo_code.dart';
import '../../domain/uses_cases/profile/edit_profile.dart';
import '../../domain/uses_cases/time_slot/get_interval_hours.dart';
import '../../presentation/profile/model_view/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init({required Box userPreferenceBox}) async {
  ///Cubit
  // sl.registerFactory(() => NewInCubit(getProductsUseCase: sl()));
  sl.registerFactory(() => HomeBloc(sl(), sl(), sl(), sl(), sl(), sl(),sl()));
  // sl.registerFactory(() => OffersCubit(sl()));
  // sl.registerFactory(() => BestSellerCubit(sl(),));
  sl.registerFactory(() => SearchCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AdScreenCubit(sl()));
  sl.registerFactory(() => CategoryCubit(sl()));
  sl.registerFactory(() => CategoryHomeCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => AccountCubit(userPreferenceRepo: sl<UserPreferenceRepo>(), getSettingsUseCase: sl(),authRepo: sl()));
  sl.registerFactory(() => ProductDetailsBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => WishlistCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ProfileCubit(sl(), sl(), sl()));
  sl.registerFactory(() => OrderLookupCubit());
  sl.registerFactory(() => LayoutCubit());
  sl.registerFactory(() => CartCubit(
      getCartProducts: sl<GetCartProducts>(),
      deleteFromCart: sl<DeleteFromCart>(),
      changeProductCartAmount: sl<ChangeProductCartAmount>(),
      addPromoCode: sl<AddPromoCode>(),
      removePromoCode: sl<RemovePromoCode>(),
      userPreferenceRepo: sl<UserPreferenceRepo>()
  ));
  sl.registerFactory(() => TrackOrderCubit(userPreferenceRepo: sl(), getOrdersByIdUseCase: sl(),cancelOrdersByIdUseCase: sl()));
  sl.registerFactory(() => OrdersCubit(getOrdersUseCase: sl(), userPreferenceRepo: sl()));

  ///datasource
  sl.registerLazySingleton<FirebaseAuthSource>(() => FirebaseAuthSourceImpl());
  sl.registerLazySingleton<BaseRemoteDataSource>(() => BaseRemoteDataSource(createAndSetupDio()));
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource(createAndSetupDio()));
  sl.registerLazySingleton<GoogleMapDataSource>(() => GoogleMapDataSource(createAndSetupDio()));
  sl.registerLazySingleton<UserPreferenceSource>(() => UserPreferenceSource(
        userPreferenceBox: userPreferenceBox,
      ));
  sl.registerLazySingleton<LocalDatabase>(() => LocalDatabase());
  sl.registerLazySingleton<CartDao>(() => CartDao(sl()));
  sl.registerLazySingleton<DynamicVariantsDao>(() => DynamicVariantsDao(sl()));

  ///repos

  sl.registerLazySingleton<BaseRepository>(() => RepositoryImp(sl(), sl(), sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authDataSource: sl(),userPreferenceRepo: sl()));
  sl.registerLazySingleton<UserPreferenceRepo>(() => UserPreferenceRepoImpl(userPreference: sl()));
  sl.registerLazySingleton(() => GetArea(baseRepository: sl()));

  ///UseCases
  sl.registerLazySingleton(() => GetCategoriesUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetSubCategoriesUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetVariantsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetProductDetailsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetWishlistsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetAddressesUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetBannersUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetCategoryWithSubsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => DeleteWishlistItemUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => SetWishlistItemUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetSettingsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetProductDynamicVariantsDetailsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetChangeOfProductDetailsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetBrandsUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetSubCategoriesOfCategoryUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetAdScreenUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => SearchUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetBlockDates(baseRepository: sl()));
  sl.registerLazySingleton(() => GetIntervalHours(baseRepository: sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetOrdersByIdUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => NotifyMeUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => GetAppThemeUseCase(baseRepository: sl()));
  sl.registerLazySingleton(() => CancelOrdersByIdUseCase(baseRepository: sl()));

  sl.registerLazySingleton(
      () => AddToCart(baseRepository: sl(), cartDao: sl(), userPreferenceRepo: sl(), dynamicVariantsDao: sl()));
  sl.registerLazySingleton(() => GetCartProducts(
        baseRepository: sl(),
        cartDao: sl(),
        userPreferenceRepo: sl(),
      ));
  sl.registerLazySingleton(() => DeleteFromCart(
        baseRepository: sl(),
        cartDao: sl(),
        userPreferenceRepo: sl(),
        dynamicVariantsDao: sl(),
      ));
  sl.registerLazySingleton(() => ChangeProductCartAmount(
        baseRepository: sl(),
        cartDao: sl(),
        userPreferenceRepo: sl(),
      ));
  sl.registerLazySingleton(() => AddPromoCode(
        baseRepository: sl(),
        cartDao: sl(),
        userPreferenceRepo: sl(),
      ));
  sl.registerLazySingleton(() => RemovePromoCode(baseRepository: sl(), cartDao: sl(), userPreferenceRepo: sl()));

  sl.registerLazySingleton(() => MigrateLocalCartToOnline(
        dynamicVariantsDao: sl(),
        baseRepository: sl(),
        cartDao: sl(),
        userPreferenceRepo: sl(),
      ));
  sl.registerLazySingleton(() => OrderSummary(baseRepository: sl()));

}

Dio createAndSetupDio() {
  Dio dio = Dio();
  dio.interceptors.addAll([AppendHeaderInterceptor()]);

  // dio
  // ..options.connectTimeout = const Duration(seconds: 5)
  // ..options.receiveTimeout = const Duration(seconds: 5);

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    error: true,
    requestHeader: true,
    responseHeader: true,
    responseBody: true,
  ));
  return dio;
}

// Dio createAndSetupDioTwo() {
//   Dio dio = Dio();
//   dio
//     ..options.connectTimeout = const Duration(seconds: 5)
//     ..options.receiveTimeout = const Duration(seconds: 5)
//     ..interceptors.addAll([AppendHeaderInterceptor()]);
//
//   dio.interceptors.add(LogInterceptor(
//     requestBody: true,
//     error: true,
//     requestHeader: true,
//     responseHeader: true,
//     responseBody: true,
//   ));
//   return dio;
// }

class AppendHeaderInterceptor extends Interceptor {
  AppendHeaderInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    options.headers['authorization'] = sl<UserPreferenceRepo>().getAccessToken();
    options.queryParameters['lang'] = sl<UserPreferenceRepo>().getLanguage();
    return super.onRequest(options, handler);
  }
}
