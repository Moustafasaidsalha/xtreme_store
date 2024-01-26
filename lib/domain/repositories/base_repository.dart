import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/ad_screen.dart';
import 'package:extreme_store/data/models/addresses_response_model.dart';
import 'package:extreme_store/data/models/app_theme.dart';
import 'package:extreme_store/data/models/area_model.dart';
import 'package:extreme_store/data/models/auth_response.dart';
import 'package:extreme_store/data/models/banner.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';
import 'package:extreme_store/data/models/brand.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/category_with_sub.dart';
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
import 'package:extreme_store/data/models/time_slot_models/interval_hours_model.dart';
import 'package:extreme_store/data/models/variant.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/uses_cases/delete_wishlist_item.dart';
import 'package:extreme_store/domain/uses_cases/get_ad_screen.dart';
import 'package:extreme_store/domain/uses_cases/get_banners.dart';
import 'package:extreme_store/domain/uses_cases/get_brands.dart';
import 'package:extreme_store/domain/uses_cases/get_categories.dart';
import 'package:extreme_store/domain/uses_cases/get_category_with_sub.dart';
import 'package:extreme_store/domain/uses_cases/get_dynamic_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_orders.dart';
import 'package:extreme_store/domain/uses_cases/get_orders_by_id.dart';
import 'package:extreme_store/domain/uses_cases/get_product_details.dart';
import 'package:extreme_store/domain/uses_cases/get_products.dart';
import 'package:extreme_store/domain/uses_cases/get_sub_category_of_category.dart';
import 'package:extreme_store/domain/uses_cases/notify_me.dart';
import 'package:extreme_store/domain/uses_cases/profile/get_profile.dart';
import 'package:extreme_store/domain/uses_cases/get_variants.dart';
import 'package:extreme_store/domain/uses_cases/get_wishlists.dart';
import 'package:extreme_store/domain/uses_cases/profile/edit_profile.dart';
import 'package:extreme_store/domain/uses_cases/set_wishlist_item.dart';

import '../../data/models/add_to_cart_body.dart';
import '../../data/models/dynamic_variants.dart';
import '../../data/models/order/order_response_model.dart';
import '../../data/models/time_slot_models/blocked_dates_model.dart';
import '../uses_cases/cancel_order.dart';
import '../uses_cases/get_change_of_product_details.dart';
import '../uses_cases/search.dart';
import '../uses_cases/time_slot/get_interval_hours.dart';

abstract class BaseRepository {
  Future<Either<Failure, VariantModel>> getVariants({required GetVariantsParams params});
  Future<Either<Failure, CategoriesModel>> getCategories({required GetCategoriesParams params});
  Future<Either<Failure, SubCategoriesModel>> getSubCategoryOfCategory(
      {required GetSubCategoriesOfCategoryParams params});
  Future<Either<Failure, SubCategoriesModel>> getSubCategories();
  Future<Either<Failure, AppThemeModel>> getAppTheme();
  Future<Either<Failure, ProductsModel>> getProducts({required GetProductsParams params});
  Future<Either<Failure, ProductsModel>> search({required SearchParams params});
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      {required GetProductDetailsParams params});

  ///Order
  Future<Either<Failure, OrderResponseModel>> addOrder({
    required AddOrderBody orderBody,
  });
  Future<Either<Failure, OrderResponseModel>> addDigitalOrder({
    required int cartID,
  });
  Future<Either<Failure, OrdersModel>> getOrders({required GetOrdersParams params});
  Future<Either<Failure, OrdersByIdModel>> getOrdersByID({required GetOrdersByIdParams params});
  Future<Either<Failure, ResponseModel>> cancelOrdersByID({required CancelOrdersByIdParams params});
  Future<Either<Failure, OrderSummaryModel>> getOrderSummary({
    required String paymentMethod ,
     int? userAddressId,
     bool? isDigital,
    required int cartId,
  });

  Future<Either<Failure, ProductDetailsModel>> getChangeOfProductDetails(
      {required GetChangeOfProductDetailsParams params});
  Future<Either<Failure, DynamicVariantsModel>> getProductDynamicVariantsDetails(
      {required GetDynamicVariantsProductDetailsParams params});
  Future<Either<Failure, WishlistsModel>> getWishlists({required GetWishlistsParams params});
  Future<Either<Failure, ProfilesModel>> getProfile({required GetProfileParams params});
  Future<Either<Failure, ResponseModel>> editProfile({required EditProfileParams params});
  Future<Either<Failure, BannersModel>> getBanners({required GetBannersParams params});
  Future<Either<Failure, AdScreensModel>> getAdScreen({required GetAddScreenParams params});
  Future<Either<Failure, BrandsModel>> getBrands({required GetBrandsParams params});

  ///Time slot
  Future<Either<Failure, IntervalHoursResponseModel>> getIntervalHours({
    required GetIntervalHoursParams params,
  });
  Future<Either<Failure, BlockDatesResponseModel>> getBlockData();
  Future<Either<Failure, CategoriesWithSubsModel>> getCategoryWithSub(
      {required GetCategoryWithSubsParams params});
  Future<Either<Failure, ResponseModel>> setWishlistItem({required SetWishlistItemParams params});
  Future<Either<Failure, ResponseModel>> notifyMe({required NotifyMeParams params});

  Future<Either<Failure, ResponseModel>> deleteWishlistItem(
      {required DeleteWishlistItemParams params});

  ///Address
  Future<Either<Failure, GoogleGecodeResponse>> getFullAddress({
    required String latLong,
    required String language,
  });
  Future<Either<Failure, List<AddressModel>>> getAddresses();
  Future<Either<Failure, AuthResponse>> addAddresses({
    required Map<String, dynamic> addAddressModel,
  });
  Future<Either<Failure, AuthResponse>> updateAddress({
    required AddAddressModel addAddressModel,
    required int addressID,
  });
  Future<Either<Failure, AuthResponse>> deleteAddress({
    required int addressID,
  });
  Future<Either<Failure, List<AreaModel>>> getArea({
    required int countryID,
  });
  Future<Either<Failure, ResponseModel>> putDefaultAddress({
    required int addressID,
  });

  Future<Either<Failure, SettingsModel>> getSettings();

  ///Cart
  Future<Either<Failure, CartResponseModel>> getCart();
  Future<Either<Failure, ResponseModel>> addToCart({
    required AddToCartBody body,
  });
  Future<Either<Failure, ResponseModel>> deleteFromCart({
    required int productID,
  });
  Future<Either<Failure, ResponseModel>> changeProductCartAmount({
    required int productID,
    required int amount,
  });
  Future<Either<Failure, CartResponseModel>> getLocalCart({
    required AddToCartLocalBody body,
  });

  ///Cart - promo code
  Future<Either<Failure, PromoCodeResponseModel>> addPromoCode({
    required int cartID,
    required String promoCodeName,
  });
  Future<Either<Failure, ResponseModel>> removePromoCode({
    required int cartID,
  });

  ///Phone number
  Future<Either<Failure, PhoneNumberResponseModel>> getUserPhoneNumber();
  Future<Either<Failure, ResponseModel>> addUSerPhoneNumber({
    required String phoneNumber,
    required String countryCode,
  });
  Future<Either<Failure, ResponseModel>> verifyUserNumber({
    required String phoneNumber,
    required String countryCode,
    required String code,
  });
  Future<Either<Failure, ResponseModel>> deleteUserPhoneNumber({
    required int phoneNumberID,
  });

  ///Settings
  Future<Either<Failure, StaticPageResponseModel>> getStaticPAge({
    required String type,
  });
}
