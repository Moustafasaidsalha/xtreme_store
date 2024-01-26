import 'package:dio/dio.dart';
import 'package:extreme_store/data/models/ad_screen.dart';
import 'package:extreme_store/data/models/addresses_response_model.dart';
import 'package:extreme_store/data/models/app_theme.dart';
import 'package:extreme_store/data/models/banner.dart';
import 'package:extreme_store/data/models/brand.dart';
import 'package:extreme_store/data/models/category.dart';
import 'package:extreme_store/data/models/category_with_sub.dart';
import 'package:extreme_store/data/models/dynamic_variants.dart';
import 'package:extreme_store/data/models/order/add_order_body.dart';
import 'package:extreme_store/data/models/order/order_response_model.dart';
import 'package:extreme_store/data/models/order/order_summary.dart';
import 'package:extreme_store/data/models/orders.dart';
import 'package:extreme_store/data/models/phone_number_response_model.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/data/models/profile.dart';
import 'package:extreme_store/data/models/promo_code_response_model.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:extreme_store/data/models/setting.dart';
import 'package:extreme_store/data/models/settings/static_page_response_model.dart';
import 'package:extreme_store/data/models/users_model.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/data/models/variant.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/add_to_cart_body.dart';
import '../../models/area_response_model.dart';
import '../../models/auth_response.dart';
import '../../models/cart_response_model.dart';
import '../../models/time_slot_models/blocked_dates_model.dart';
import '../../models/time_slot_models/interval_hours_model.dart';

part 'data_source.g.dart';

@RestApi(baseUrl: "https://back.xtremestorekw.com/api/")
abstract class BaseRemoteDataSource {
  factory BaseRemoteDataSource(Dio dio, {String baseUrl}) = _BaseRemoteDataSource;

  /// - Categories
  @GET("categories")
  Future<CategoriesModel> getCategories({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });

  @GET("categories/CategoriesWithSubCategory")
  Future<CategoriesWithSubsModel> getCategoryWithSub({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });

  @GET("categories/getSubCategory")
  Future<SubCategoriesModel> getSubCategories();

  @GET("categories/getSubCategoryOfCategory/{id}")
  Future<SubCategoriesModel> getSubCategoryOfCategory({
    @Path("id") required int categoryId,
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });

  @GET("categories/getVariant/{category_id}")
  Future<VariantModel> getVariants({@Path("category_id") required int categoryId});

  /// - Brands
  @GET("brands")
  Future<BrandsModel> getBrands({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });

  /// - Product
@GET("control/mobileLogo")
Future<AppThemeModel> getAppTheme();
  @GET("product")
  Future<ProductsModel> getProducts({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
    @Query("bestSeller") required bool bestSeller,
    @Query("newIn") required bool newIn,
    @Query("category_id") int? categoryId,
    @Query("sub_category_id") int? subCategoryId,
    @Query("brand_id") int? brandId,
    @Query("offer") required bool offer,
    @Query("country_id") required int countryID,
  });

  @GET("product/{id}")
  Future<ProductDetailsModel> getProductDetails({
    @Path("id") required int productId,
    @Query("country_id") required int countryID,
  });

  @GET("product/dynamicVariantsOfProduct/{id}")
  Future<DynamicVariantsModel> getProductDynamicVariantsDetails({
    @Path("id") required int productId,
    @Query("country_id") required int countryID,
  });

  @GET("product/changeProduct/{code}")
  Future<ProductDetailsModel> getChangeOfProductDetails({
    @Path("code") required int productCode,
    @Query("variant_value_ids") required List<String> variantValueIds,
    @Query("country_id") required int countryID,
  });

  /// - banner - ads
  @GET("banner")
  Future<BannersModel> getBanners({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });

  @GET("screen")
  Future<AdScreensModel> getAdScreen({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });

  /// - search
  @GET("search")
  Future<ProductsModel> search({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
    @Query("name") String? name,
    @Query("bestSeller") required bool bestSeller,
    @Query("newIn") required bool newIn,
    @Query("offer") required bool offer,
    @Query("category_id") int? categoryId,
    @Query("sub_category_id") int? subCategoryId,
    @Query("sort_by") String? sortBy,
    @Query("country_id") required int countryID,
  });

  /// - Order
  @POST("order")
  Future<OrderResponseModel> addOrder({
    @Body() required AddOrderBody orderBody,
  });
  @POST("order/digital")
  Future<OrderResponseModel> addDigitalOrder({
    @Field('cart_id') required int cartID,
  });
  @GET("order/myOrder/{id}")
  Future<OrdersByIdModel> getOrdersById({
    @Path("id") required int id,
  });
  @PUT("order/myOrder/{id}")
  Future<ResponseModel> cancelOrdersById({
    @Path("id") required int id,
  });
  @GET("order/myOrders")
  Future<OrdersModel> getOrders({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
  });
  @GET("order/orderSummary")
  Future<OrderSummaryModel> getOrderSummary({
    @Query("payment_method") required String paymentMethod,
    @Query("cart_id") required int cartId,
    @Query("is_digital")  bool? isDigital,
    @Query("user_address_id")  int? userAddressID,
  });

  ///Time slot
  @GET("timeSlot/blockDateAndDayOff")
  Future<BlockDatesResponseModel> getBlockDate();

  @GET("timeSlot/intervalHours")
  Future<IntervalHoursResponseModel> getIntervalHours({
    @Query("date") required String date,
  });

  /// - User
  @GET("users/profile")
  Future<ProfilesModel> getProfile();

  @GET("setting")
  Future<SettingsModel> getSettings();

  @PUT("users")
  Future<ResponseModel> editProfile({
    @Body() required EditProfileModel usersModel,
  });

  /// - Wish List
  @GET("wishlist")
  Future<WishlistsModel> getWishlists({
    @Query("offset") required int offset,
    @Query("limit") required int limit,
    @Query("country_id") required int countryID,
  });

  @POST("wishlist")
  Future<ResponseModel> setWishlistItem({
    @Body() required ProductIdModel productID,
  });

  @DELETE("wishlist")
  Future<ResponseModel> deleteWishlistItem({
    @Body() required ProductIdModel productID,
  });

  /// - Notification
  @POST("notification/notifyMy")
  Future<ResponseModel> notifyMe({
    @Body() required ProductIdModel productID,
  });



  ///Addresses
  @GET("users/address")
  Future<AddressesResponseModel> getAddresses();

  @GET("/users/area/{country_id}")
  Future<AreaResponseModel> getArea({
    @Path("country_id") required int countryID,
  });

  @POST("users/address")
  Future<AuthResponse> addAddresses({
    @Body() required Map<String, dynamic> addAddressModel,
  });

  @DELETE("users/address/{id}")
  Future<AuthResponse> deleteAddresses({
    @Path("id") required int id,
  });

  @PUT("users/address/{id}")
  Future<AuthResponse> updateAddresses({
    @Path("id") required int id,
    @Body() required AddAddressModel addAddressModel,
  });

  @PUT("users/defaultAddress/{id}")
  Future<ResponseModel> putDefaultAddress({
    @Path("id") required int id,
  });

  ///Cart
  @GET("cart")
  Future<CartResponseModel> getCart({
    @Query("country_id") required int countryID,
  });
  @POST("cart")
  Future<ResponseModel> addToCart({
    @Body() required AddToCartBody addToCartBody,
  });
  @PUT("cart")
  Future<ResponseModel> changeProductAmountInCart({
    @Field("product_id") required int productID,
    @Field("amount") required int amount,
  });
  @DELETE("cart")
  Future<ResponseModel> deleteFromCart({
    @Field("product_id") required int productID,
  });
  @POST("cart/calcForLocalCart")
  Future<CartResponseModel> getLocalCart({
    @Body() required AddToCartLocalBody localBody,
    @Query("country_id") required int countryID,
  });

  ///Cart - Promo Code
  @POST("cart/promoCode")
  Future<PromoCodeResponseModel> addPromoCode({
    @Field("promoCode") required String promoCode,
    @Field("cart_id") required int cartID,
  });
  @DELETE("cart/promoCode")
  Future<ResponseModel> removePromoCode({
    @Field("cart_id") required int cartID,
  });

  ///phone
  @GET("users/phone")
  Future<PhoneNumberResponseModel> getUserPhones();
  @POST("users/phone")
  Future<ResponseModel> addUserPhone({
    @Field("phone") required String phoneNumber,
    @Field("country_code") required String countryCode,
  });
  @POST("users/verifyPhone")
  Future<ResponseModel> verifyUserPhoneNumber({
    @Field("phone") required String phoneNumber,
    @Field("country_code") required String countryCode,
    @Field("code") required String code,
  });
  @DELETE("users/phone/{id}")
  Future<ResponseModel> deleteUserPhoneNumber({
    @Path("id") required int id,
  });

  ///Settings
  @GET("staticPage")
  Future<StaticPageResponseModel> getStaticPage({
    @Query("type") required String type,
  });
}
