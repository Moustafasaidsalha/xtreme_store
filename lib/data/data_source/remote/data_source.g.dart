// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _BaseRemoteDataSource implements BaseRemoteDataSource {
  _BaseRemoteDataSource(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://back.xtremestorekw.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CategoriesModel> getCategories({
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CategoriesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CategoriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoriesWithSubsModel> getCategoryWithSub({
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoriesWithSubsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories/CategoriesWithSubCategory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CategoriesWithSubsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubCategoriesModel> getSubCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SubCategoriesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories/getSubCategory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SubCategoriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubCategoriesModel> getSubCategoryOfCategory({
    required int categoryId,
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SubCategoriesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories/getSubCategoryOfCategory/${categoryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SubCategoriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VariantModel> getVariants({required int categoryId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<VariantModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories/getVariant/${categoryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = VariantModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BrandsModel> getBrands({
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BrandsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'brands',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BrandsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AppThemeModel> getAppTheme() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AppThemeModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'control/mobileLogo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AppThemeModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductsModel> getProducts({
    required int offset,
    required int limit,
    required bool bestSeller,
    required bool newIn,
    int? categoryId,
    int? subCategoryId,
    int? brandId,
    required bool offer,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
      r'bestSeller': bestSeller,
      r'newIn': newIn,
      r'category_id': categoryId,
      r'sub_category_id': subCategoryId,
      r'brand_id': brandId,
      r'offer': offer,
      r'country_id': countryID,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProductsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'product',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProductsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductDetailsModel> getProductDetails({
    required int productId,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryID};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductDetailsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'product/${productId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProductDetailsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DynamicVariantsModel> getProductDynamicVariantsDetails({
    required int productId,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryID};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DynamicVariantsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'product/dynamicVariantsOfProduct/${productId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DynamicVariantsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductDetailsModel> getChangeOfProductDetails({
    required int productCode,
    required List<String> variantValueIds,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'variant_value_ids': variantValueIds,
      r'country_id': countryID,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductDetailsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'product/changeProduct/${productCode}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProductDetailsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BannersModel> getBanners({
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BannersModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'banner',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BannersModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AdScreensModel> getAdScreen({
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AdScreensModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'screen',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AdScreensModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductsModel> search({
    required int offset,
    required int limit,
    String? name,
    required bool bestSeller,
    required bool newIn,
    required bool offer,
    int? categoryId,
    int? subCategoryId,
    String? sortBy,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
      r'name': name,
      r'bestSeller': bestSeller,
      r'newIn': newIn,
      r'offer': offer,
      r'category_id': categoryId,
      r'sub_category_id': subCategoryId,
      r'sort_by': sortBy,
      r'country_id': countryID,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProductsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProductsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderResponseModel> addOrder({required AddOrderBody orderBody}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(orderBody.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrderResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OrderResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderResponseModel> addDigitalOrder({required int cartID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'cart_id': cartID};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrderResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/digital',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OrderResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrdersByIdModel> getOrdersById({required int id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrdersByIdModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/myOrder/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OrdersByIdModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> cancelOrdersById({required int id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/myOrder/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrdersModel> getOrders({
    required int offset,
    required int limit,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrdersModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/myOrders',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OrdersModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderSummaryModel> getOrderSummary({
    required String paymentMethod,
    required int cartId,
    bool? isDigital,
    int? userAddressID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'payment_method': paymentMethod,
      r'cart_id': cartId,
      r'is_digital': isDigital,
      r'user_address_id': userAddressID,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrderSummaryModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/orderSummary',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OrderSummaryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BlockDatesResponseModel> getBlockDate() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BlockDatesResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'timeSlot/blockDateAndDayOff',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BlockDatesResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<IntervalHoursResponseModel> getIntervalHours(
      {required String date}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<IntervalHoursResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'timeSlot/intervalHours',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = IntervalHoursResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProfilesModel> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProfilesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/profile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProfilesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SettingsModel> getSettings() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SettingsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'setting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SettingsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> editProfile(
      {required EditProfileModel usersModel}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(usersModel.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WishlistsModel> getWishlists({
    required int offset,
    required int limit,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
      r'country_id': countryID,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<WishlistsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'wishlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = WishlistsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> setWishlistItem(
      {required ProductIdModel productID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(productID.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'wishlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> deleteWishlistItem(
      {required ProductIdModel productID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(productID.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'wishlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> notifyMe({required ProductIdModel productID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(productID.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'notification/notifyMy',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddressesResponseModel> getAddresses() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddressesResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/address',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddressesResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AreaResponseModel> getArea({required int countryID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AreaResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/area/${countryID}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AreaResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthResponse> addAddresses(
      {required Map<String, dynamic> addAddressModel}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addAddressModel);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AuthResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/address',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthResponse> deleteAddresses({required int id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AuthResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/address/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthResponse> updateAddresses({
    required int id,
    required AddAddressModel addAddressModel,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addAddressModel.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AuthResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/address/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> putDefaultAddress({required int id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/defaultAddress/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CartResponseModel> getCart({required int countryID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryID};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CartResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CartResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> addToCart(
      {required AddToCartBody addToCartBody}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addToCartBody.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> changeProductAmountInCart({
    required int productID,
    required int amount,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'product_id': productID,
      'amount': amount,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> deleteFromCart({required int productID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'product_id': productID};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CartResponseModel> getLocalCart({
    required AddToCartLocalBody localBody,
    required int countryID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryID};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(localBody.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CartResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart/calcForLocalCart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CartResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PromoCodeResponseModel> addPromoCode({
    required String promoCode,
    required int cartID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'promoCode': promoCode,
      'cart_id': cartID,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PromoCodeResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart/promoCode',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PromoCodeResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> removePromoCode({required int cartID}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'cart_id': cartID};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'cart/promoCode',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PhoneNumberResponseModel> getUserPhones() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhoneNumberResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/phone',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PhoneNumberResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> addUserPhone({
    required String phoneNumber,
    required String countryCode,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'phone': phoneNumber,
      'country_code': countryCode,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/phone',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> verifyUserPhoneNumber({
    required String phoneNumber,
    required String countryCode,
    required String code,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'phone': phoneNumber,
      'country_code': countryCode,
      'code': code,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/verifyPhone',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseModel> deleteUserPhoneNumber({required int id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResponseModel>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/phone/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StaticPageResponseModel> getStaticPage({required String type}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'type': type};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StaticPageResponseModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'staticPage',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = StaticPageResponseModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
