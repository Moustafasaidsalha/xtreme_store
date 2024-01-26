// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      ordersMetaModel: json['meta'] == null
          ? null
          : OrdersMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.ordersMetaModel,
    };

OrdersByIdModel _$OrdersByIdModelFromJson(Map<String, dynamic> json) =>
    OrdersByIdModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      ordersDataModel: json['data'] == null
          ? null
          : OrdersDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrdersByIdModelToJson(OrdersByIdModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.ordersDataModel,
    };

OrdersMetaModel _$OrdersMetaModelFromJson(Map<String, dynamic> json) =>
    OrdersMetaModel(
      totalLength: json['totalLength'] as int?,
      ordersDataModel: (json['data'] as List<dynamic>?)
          ?.map((e) => OrdersDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersMetaModelToJson(OrdersMetaModel instance) =>
    <String, dynamic>{
      'totalLength': instance.totalLength,
      'data': instance.ordersDataModel,
    };

OrdersDataModel _$OrdersDataModelFromJson(Map<String, dynamic> json) =>
    OrdersDataModel(
      id: json['id'] as int?,
      day: json['day'] as String?,
      status: json['status'] as String?,
      paymentMethod: json['payment_method'] as String?,
      userId: json['user_id'] as int?,
      userAddressId: json['user_address_id'] as int?,
      cartId: json['cart_id'] as int?,
      intervalHoursId: json['interval_hours_id'] as int?,
      userAddress: json['user_address'] == null
          ? null
          : UserAddressModel.fromJson(
              json['user_address'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      intervalHour: json['intervalHour'] == null
          ? null
          : IntervalHourModel.fromJson(
              json['intervalHour'] as Map<String, dynamic>),
      subCarts: (json['sub_carts'] as List<dynamic>?)
          ?.map((e) => SubCarts.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      shippingFee: (json['shipping_fee'] as num?)?.toDouble(),
      couponName: json['coupon_name'] as String?,
      couponValue: (json['coupon_value'] as num?)?.toDouble(),
      couponType: json['coupon_type'] as String?,
    );

Map<String, dynamic> _$OrdersDataModelToJson(OrdersDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'status': instance.status,
      'payment_method': instance.paymentMethod,
      'user_id': instance.userId,
      'user_address_id': instance.userAddressId,
      'cart_id': instance.cartId,
      'interval_hours_id': instance.intervalHoursId,
      'user_address': instance.userAddress,
      'user': instance.user,
      'intervalHour': instance.intervalHour,
      'sub_carts': instance.subCarts,
      'sub_total': instance.subTotal,
      'total': instance.total,
      'shipping_fee': instance.shippingFee,
      'coupon_name': instance.couponName,
      'coupon_value': instance.couponValue,
      'coupon_type': instance.couponType,
    };

IntervalHourModel _$IntervalHourModelFromJson(Map<String, dynamic> json) =>
    IntervalHourModel(
      day: json['day'] == null
          ? null
          : DayModel.fromJson(json['day'] as Map<String, dynamic>),
      to: json['to'] as String?,
      from: json['from'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$IntervalHourModelToJson(IntervalHourModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'to': instance.to,
      'from': instance.from,
      'id': instance.id,
    };

DayModel _$DayModelFromJson(Map<String, dynamic> json) => DayModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DayModelToJson(DayModel instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

DynamicVariantCartModel _$DynamicVariantCartModelFromJson(
        Map<String, dynamic> json) =>
    DynamicVariantCartModel(
      dynamicVariant: json['dynamic_variant'] == null
          ? null
          : DynamicVariantModel.fromJson(
              json['dynamic_variant'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
      dynamicVariantId: json['dynamic_variant_id'] as int?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DynamicVariantCartModelToJson(
        DynamicVariantCartModel instance) =>
    <String, dynamic>{
      'dynamic_variant': instance.dynamicVariant,
      'amount': instance.amount,
      'dynamic_variant_id': instance.dynamicVariantId,
      'id': instance.id,
    };

DynamicVariantModel _$DynamicVariantModelFromJson(Map<String, dynamic> json) =>
    DynamicVariantModel(
      categoryId: json['category_id'] as int?,
      price: json['price'] as int?,
      hasAmount: json['has_amount'] as bool?,
      availableAmount: json['available_amount'] as int?,
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DynamicVariantModelToJson(
        DynamicVariantModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'price': instance.price,
      'has_amount': instance.hasAmount,
      'available_amount': instance.availableAmount,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'id': instance.id,
    };

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => BrandModel(
      json['name_ar'] as String?,
      json['name_en'] as String?,
    );

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      json['url'] as String?,
      json['id'] as int?,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      brandId: json['brand_id'] as int?,
      subCategoryId: json['sub_category_id'] as int?,
      categoryId: json['category_id'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      weight: json['weight'] as int?,
      offerPrice: (json['offerPrice'] as num?)?.toDouble(),
      offer: json['offer'] as bool?,
      newIn: json['newIn'] as bool?,
      bestSeller: json['bestSeller'] as bool?,
      amount: json['amount'] as int?,
      code: json['code'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      id: json['id'] as int?,
      brand: json['brand'] == null
          ? null
          : BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      subCategory: json['sub_category'] == null
          ? null
          : BrandModel.fromJson(json['sub_category'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'sub_category': instance.subCategory,
      'images': instance.images,
      'brand_id': instance.brandId,
      'sub_category_id': instance.subCategoryId,
      'category_id': instance.categoryId,
      'isDeleted': instance.isDeleted,
      'weight': instance.weight,
      'offerPrice': instance.offerPrice,
      'offer': instance.offer,
      'newIn': instance.newIn,
      'bestSeller': instance.bestSeller,
      'amount': instance.amount,
      'code': instance.code,
      'description_ar': instance.descriptionAr,
      'description_en': instance.descriptionEn,
      'price': instance.price,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'id': instance.id,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      phone: json['phone'] as String?,
      countryCode: json['country_code'] as String?,
      email: json['email'] as String?,
      lName: json['l_name'] as String?,
      fName: json['f_name'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'phone': instance.phone,
      'country_code': instance.countryCode,
      'email': instance.email,
      'l_name': instance.lName,
      'f_name': instance.fName,
      'id': instance.id,
    };

UserAddressModel _$UserAddressModelFromJson(Map<String, dynamic> json) =>
    UserAddressModel(
      phone: json['phone'] as String?,
      countryCode: json['country_code'] as String?,
      areaId: json['area_id'] as int?,
      countryId: json['country_id'] as int?,
      userId: json['user_id'] as int?,
      isDefault: json['is_default'] as bool?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      otherInstructions: json['otherInstructions'] as String?,
      aptNumber: json['aptNumber'] as int?,
      houseNumber: json['houseNumber'] as String?,
      officeNumber: json['officeNumber'] as int?,
      floorNumber: json['floorNumber'] as int?,
      buildingNumber: json['buildingNumber'] as int?,
      type: json['type'] as String?,
      avenue: json['avenue'] as String?,
      street: json['street'] as String?,
      block: json['block'] as String?,
      addressName: json['addressName'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UserAddressModelToJson(UserAddressModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'country_code': instance.countryCode,
      'area_id': instance.areaId,
      'country_id': instance.countryId,
      'user_id': instance.userId,
      'is_default': instance.isDefault,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'otherInstructions': instance.otherInstructions,
      'aptNumber': instance.aptNumber,
      'houseNumber': instance.houseNumber,
      'officeNumber': instance.officeNumber,
      'floorNumber': instance.floorNumber,
      'buildingNumber': instance.buildingNumber,
      'type': instance.type,
      'avenue': instance.avenue,
      'street': instance.street,
      'block': instance.block,
      'addressName': instance.addressName,
      'id': instance.id,
    };
