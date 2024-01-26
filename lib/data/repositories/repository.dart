import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/data_source/remote/data_source.dart';
import 'package:extreme_store/data/data_source/remote/google_maps_data_source.dart';
import 'package:extreme_store/data/models/ad_screen.dart';
import 'package:extreme_store/data/models/addresses_response_model.dart';
import 'package:extreme_store/data/models/app_theme.dart';
import 'package:extreme_store/data/models/area_model.dart';
import 'package:extreme_store/data/models/auth_response.dart';
import 'package:extreme_store/data/models/banner.dart';
import 'package:extreme_store/data/models/brand.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/category_with_sub.dart';
import 'package:extreme_store/data/models/dynamic_variants.dart';
import 'package:extreme_store/data/models/google_gecode_response.dart';
import 'package:extreme_store/data/models/order/add_order_body.dart';
import 'package:extreme_store/data/models/order/order_summary.dart';
import 'package:extreme_store/data/models/orders.dart';
import 'package:extreme_store/data/models/phone_number_response_model.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/data/models/profile.dart';
import 'package:extreme_store/data/models/promo_code_response_model.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:extreme_store/data/models/setting.dart';
import 'package:extreme_store/data/models/settings/static_page_response_model.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/data/models/variant.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';
import 'package:extreme_store/domain/uses_cases/cancel_order.dart';
import 'package:extreme_store/domain/uses_cases/delete_wishlist_item.dart';
import 'package:extreme_store/domain/repositories/user_preference_repo.dart';
import 'package:extreme_store/domain/uses_cases/get_ad_screen.dart';
import 'package:extreme_store/domain/uses_cases/get_banners.dart';
import 'package:extreme_store/domain/uses_cases/get_brands.dart';
import 'package:extreme_store/domain/uses_cases/get_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_category_with_sub.dart';
import 'package:extreme_store/domain/uses_cases/get_change_of_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_dynamic_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_orders.dart';
import 'package:extreme_store/domain/uses_cases/get_orders_by_id.dart';
import 'package:extreme_store/domain/uses_cases/notify_me.dart';
import 'package:extreme_store/domain/uses_cases/time_slot/get_interval_hours.dart';
import 'package:extreme_store/domain/uses_cases/get_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_category_of_category.dart';
import 'package:extreme_store/domain/uses_cases/profile/get_profile.dart';
import 'package:extreme_store/domain/uses_cases/get_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_wishlists.dart';
import 'package:extreme_store/domain/uses_cases/profile/edit_profile.dart';
import 'package:extreme_store/domain/uses_cases/search.dart';
import 'package:extreme_store/domain/uses_cases/set_wishlist_item.dart';

import '../models/add_to_cart_body.dart';
import '../models/order/order_response_model.dart';
import '../models/time_slot_models/blocked_dates_model.dart';
import '../models/time_slot_models/interval_hours_model.dart';

class RepositoryImp extends BaseRepository {
  RepositoryImp(this.baseRemoteDataSource, this.googleMapDataSource, this.userPreferenceRepo);
  final BaseRemoteDataSource baseRemoteDataSource;
  final GoogleMapDataSource googleMapDataSource;
  final UserPreferenceRepo userPreferenceRepo;

  @override
  Future<Either<Failure, CategoriesModel>> getCategories({required GetCategoriesParams params}) async {
    try {
      final result = await baseRemoteDataSource.getCategories(offset: params.offset, limit: params.limit);

      return Right(result);
      // }on ServerException catch(failure){

      //   return Left(ServerFailure(failure));
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> getProducts({required GetProductsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getProducts(
        offset: params.offset,
        limit: params.limit,
        bestSeller: params.bestSeller,
        newIn: params.newIn,
        offer: params.offer,
        subCategoryId: params.subCategoryId,
        categoryId: params.categoryId,
        brandId: params.brandId,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );
      return Right(result);
      // }on ServerException catch(failure){
      //   return Left(ServerFailure(failure.errorMessageModel.message));
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, SubCategoriesModel>> getSubCategories() async {
    try {
      final result = await baseRemoteDataSource.getSubCategories();

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, VariantModel>> getVariants({required GetVariantsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getVariants(categoryId: params.categoryId);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
      // }on ServerException catch(failure){
      // return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails({required GetProductDetailsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getProductDetails(
        productId: params.productId,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );
      return Right(result);
      // }on ServerException catch(failure){

      //   return Left(ServerFailure(failure));
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, WishlistsModel>> getWishlists({required GetWishlistsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getWishlists(
        offset: params.offset,
        limit: params.limit,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );
      return Right(result);
      // }on ServerException catch(failure){

      //   return Left(ServerFailure(failure));
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, BannersModel>> getBanners({required GetBannersParams params}) async {
    try {
      final result = await baseRemoteDataSource.getBanners(limit: params.limit, offset: params.offset);

      return Right(result);
      // }on ServerException catch(failure){

      //   return Left(ServerFailure(failure));
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ProfilesModel>> getProfile({required GetProfileParams params}) async {
    try {
      final result = await baseRemoteDataSource.getProfile();

      return Right(result);
      // }on ServerException catch(failure){

      //   return Left(ServerFailure(failure));
    } on ServerFailure catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> editProfile({required EditProfileParams params}) async {
    try {
      final result = await baseRemoteDataSource.editProfile(usersModel: params.usersModel);

      return Right(result);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, CategoriesWithSubsModel>> getCategoryWithSub(
      {required GetCategoryWithSubsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getCategoryWithSub(offset: params.offset, limit: params.limit);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  ///Address

  @override
  Future<Either<Failure, List<AreaModel>>> getArea({required int countryID}) async {
    try {
      final response = await baseRemoteDataSource.getArea(
        countryID: countryID,
      );

      if (kDebugMode) {
        print(response);
      }
      if (response.flag ?? false) {
        return Right(response.areaList ?? []);
      } else {
        return const Left(ServerFailure(''));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure(e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, GoogleGecodeResponse>> getFullAddress({
    required String latLong,
    required String language,
  }) async {
    try {
      final response = await googleMapDataSource.getFullAddress(
        lang: 'ar',
        latLang: latLong,
      );

      if (kDebugMode) {
        print(response.status);
        print(response.status);
      }
      return Right(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure(e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final result = await baseRemoteDataSource.getAddresses();
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result.addresses ?? []);
      } else {
        return const Left(ServerFailure('Something wrong'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> addAddresses({
    required Map<String, dynamic> addAddressModel,
  }) async {
    try {
      final result = await baseRemoteDataSource.addAddresses(
        addAddressModel: addAddressModel,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> deleteAddress({
    required int addressID,
  }) async {
    try {
      final response = await baseRemoteDataSource.deleteAddresses(
        id: addressID,
      );

      if (kDebugMode) {
        print(response);
      }
      return Right(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure(e.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> deleteWishlistItem({
    required DeleteWishlistItemParams params,
  }) async {
    try {
      final result = await baseRemoteDataSource.deleteWishlistItem(productID: params.productID);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> setWishlistItem({required SetWishlistItemParams params}) async {
    try {
      final result = await baseRemoteDataSource.setWishlistItem(productID: params.productID);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> updateAddress({
    required AddAddressModel addAddressModel,
    required int addressID,
  }) async {
    try {
      final response = await baseRemoteDataSource.updateAddresses(
        id: addressID,
        addAddressModel: addAddressModel,
      );

      if (kDebugMode) {
        print(response);
      }
      return Right(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> putDefaultAddress({
    required int addressID,
  }) async {
    try {
      final response = await baseRemoteDataSource.putDefaultAddress(
        id: addressID,
      );

      if (kDebugMode) {
        print(response);
      }
      return Right(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      final result = await baseRemoteDataSource.getSettings();

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DynamicVariantsModel>> getProductDynamicVariantsDetails(
      {required GetDynamicVariantsProductDetailsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getProductDynamicVariantsDetails(
        productId: params.productId,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );
      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ProductDetailsModel>> getChangeOfProductDetails(
      {required GetChangeOfProductDetailsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getChangeOfProductDetails(
        productCode: params.productCode,
        variantValueIds: params.variantValueIds,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ""));
      }
    } on DioException catch (e) {
      return left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  ///Cart
  @override
  Future<Either<Failure, CartResponseModel>> getCart() async {
    try {
      var countryID = userPreferenceRepo.getSelectedCountryID();
      final result = await baseRemoteDataSource.getCart(countryID: countryID);
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      if ((e.response?.statusCode ?? 0) == 404) {
        return Left(DataFailure(
          messageD: e.response?.data['message'] ?? '',
          failureCode: e.response?.statusCode,
        ));
      } else {
        return Left(ServerFailure(e.response?.data['message'] ?? ''));
      }
    }
  }

  @override
  Future<Either<Failure, BrandsModel>> getBrands({required GetBrandsParams params}) async {
    try {
      final result = await baseRemoteDataSource.getBrands(offset: params.offset, limit: params.limit);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> addToCart({required AddToCartBody body}) async {
    try {
      final result = await baseRemoteDataSource.addToCart(
        addToCartBody: body,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return const Left(ServerFailure('Something wrong'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> deleteFromCart({required int productID}) async {
    try {
      final result = await baseRemoteDataSource.deleteFromCart(
        productID: productID,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return const Left(ServerFailure('Something wrong'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> changeProductCartAmount({
    required int productID,
    required int amount,
  }) async {
    try {
      final result = await baseRemoteDataSource.changeProductAmountInCart(
        productID: productID,
        amount: amount,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return const Left(ServerFailure('Something wrong'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> getLocalCart({required AddToCartLocalBody body}) async {
    try {
      final result = await baseRemoteDataSource.getLocalCart(
        localBody: body,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return const Left(ServerFailure('Something wrong'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  ///Cart - Promo code
  @override
  Future<Either<Failure, PromoCodeResponseModel>> addPromoCode({
    required int cartID,
    required String promoCodeName,
  }) async {
    try {
      final result = await baseRemoteDataSource.addPromoCode(
        cartID: cartID,
        promoCode: promoCodeName,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> removePromoCode({required int cartID}) async {
    try {
      final result = await baseRemoteDataSource.removePromoCode(
        cartID: cartID,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  ///Phone number
  @override
  Future<Either<Failure, ResponseModel>> addUSerPhoneNumber({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      final result = await baseRemoteDataSource.addUserPhone(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> deleteUserPhoneNumber({
    required int phoneNumberID,
  }) async {
    try {
      final result = await baseRemoteDataSource.deleteUserPhoneNumber(
        id: phoneNumberID,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, PhoneNumberResponseModel>> getUserPhoneNumber() async {
    try {
      final result = await baseRemoteDataSource.getUserPhones();
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> verifyUserNumber({
    required String phoneNumber,
    required String countryCode,
    required String code,
  }) async {
    try {
      final result = await baseRemoteDataSource.verifyUserPhoneNumber(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        code: code,
      );
      if (kDebugMode) {
        print(result);
      }
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, SubCategoriesModel>> getSubCategoryOfCategory(
      {required GetSubCategoriesOfCategoryParams params}) async {
    final result = await baseRemoteDataSource.getSubCategoryOfCategory(
        categoryId: params.categoryId, offset: params.offset, limit: params.limit);

    try {
      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, AdScreensModel>> getAdScreen({required GetAddScreenParams params}) async {
    try {
      final result = await baseRemoteDataSource.getAdScreen(offset: params.offset, limit: params.limit);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, BlockDatesResponseModel>> getBlockData() async {
    try {
      final result = await baseRemoteDataSource.getBlockDate();
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, IntervalHoursResponseModel>> getIntervalHours({
    required GetIntervalHoursParams params,
  }) async {
    try {
      final result = await baseRemoteDataSource.getIntervalHours(
        date: params.date,
      );
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> search({required SearchParams params}) async {
    try {
      final result = await baseRemoteDataSource.search(
        offset: params.offset,
        limit: params.limit,
        bestSeller: params.bestSeller,
        newIn: params.newIn,
        offer: params.offer,
        categoryId: params.categoryId,
        subCategoryId: params.subCategoryId,
        name: params.name,
        sortBy: params.sortBy,
        countryID: userPreferenceRepo.getSelectedCountryID(),
      );

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OrdersModel>> getOrders({required GetOrdersParams params}) async {
    try {
      final result = await baseRemoteDataSource.getOrders(
        offset: params.offset,
        limit: params.limit,
      );
      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OrdersByIdModel>> getOrdersByID({required GetOrdersByIdParams params}) async {
    try {
      final result = await baseRemoteDataSource.getOrdersById(id: params.id);

      return Right(result);
    } on DioException catch (e) {
      if ((e.response?.statusCode ?? 0) == 404) {
        return Left(ServerFailure(e.response?.data['message'] ?? ''));
      } else {
        return Left(ServerFailure(e.response?.data['message'] ?? ''));
      }
    }
  }

  @override
  Future<Either<Failure, OrderResponseModel>> addOrder({required AddOrderBody orderBody}) async {
    try {
      final result = await baseRemoteDataSource.addOrder(
        orderBody: orderBody,
      );
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, StaticPageResponseModel>> getStaticPAge({
    required String type,
  }) async {
    try {
      final result = await baseRemoteDataSource.getStaticPage(
        type: type,
      );
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> notifyMe({required NotifyMeParams params}) async {
    try {
      final result = await baseRemoteDataSource.notifyMe(productID: params.productID);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, AppThemeModel>> getAppTheme() async {
    try {
      final result = await baseRemoteDataSource.getAppTheme();
      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> cancelOrdersByID({required CancelOrdersByIdParams params}) async {
    try {
      final result = await baseRemoteDataSource.cancelOrdersById(id: params.id);

      return Right(result);
    } on ServerFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OrderSummaryModel>> getOrderSummary({
    required String paymentMethod,
    int? userAddressId,
    bool? isDigital,
    required int cartId,
  }) async {
    try {
      final result = await baseRemoteDataSource.getOrderSummary(
        paymentMethod: paymentMethod,
        isDigital: isDigital,
        cartId: cartId,
        userAddressID: userAddressId,
      );
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, OrderResponseModel>> addDigitalOrder({required int cartID}) async{
    try {
      final result = await baseRemoteDataSource.addDigitalOrder(
        cartID: cartID,
      );
      if (result.flag ?? false) {
        return Right(result);
      } else {
        return Left(ServerFailure(result.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }

  }
}
