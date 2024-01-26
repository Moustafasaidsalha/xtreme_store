import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';

part 'orders.g.dart';

@JsonSerializable()
class OrdersModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")
  final OrdersMetaModel? ordersMetaModel;

  const OrdersModel({
    this.message,
    this.status,
    this.flag,
    this.ordersMetaModel,
  });

  @override
  List<Object?> get props => [message, status, flag, ordersMetaModel];

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);
}

@JsonSerializable()
class OrdersByIdModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "data")
  final OrdersDataModel? ordersDataModel;

  const OrdersByIdModel({
    this.message,
    this.status,
    this.flag,
    this.ordersDataModel,
  });

  @override
  List<Object?> get props => [message, status, flag, ordersDataModel];

  factory OrdersByIdModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersByIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersByIdModelToJson(this);
}

@JsonSerializable()
class OrdersMetaModel extends Equatable {
  final int? totalLength;
  @JsonKey(name: "data")
  final List<OrdersDataModel>? ordersDataModel;

  const OrdersMetaModel({
    this.totalLength,
    this.ordersDataModel,
  });

  @override
  List<Object?> get props => [totalLength, ordersDataModel];

  factory OrdersMetaModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersMetaModelToJson(this);
}

@JsonSerializable()
class OrdersDataModel extends Equatable {
  final int? id;
  final String? day;
  final String? status;
  @JsonKey(name: "payment_method")
  final String? paymentMethod;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "user_address_id")
  final int? userAddressId;
  @JsonKey(name: "cart_id")
  final int? cartId;
  @JsonKey(name: "interval_hours_id")
  final int? intervalHoursId;
  @JsonKey(name: "user_address")
  final UserAddressModel? userAddress;
  final UserModel? user;
  final IntervalHourModel? intervalHour;
  @JsonKey(name: "sub_carts")
  final List<SubCarts>? subCarts;
  @JsonKey(name: "sub_total")
  final double? subTotal;
  final double? total;
  @JsonKey(name: "shipping_fee")
  final double? shippingFee;
  @JsonKey(name: "coupon_name")
  final String? couponName;
  @JsonKey(name: "coupon_value")
  final double? couponValue;
  @JsonKey(name: "coupon_type")
  final String? couponType;

  const OrdersDataModel({
    this.id,
    this.day,
    this.status,
    this.paymentMethod,
    this.userId,
    this.userAddressId,
    this.cartId,
    this.intervalHoursId,
    this.userAddress,
    this.user,
    this.intervalHour,
    this.subCarts,
    this.subTotal,
    this.total,
    this.shippingFee,
    this.couponName,
    this.couponValue,
    this.couponType,
  });

  @override
  List<Object?> get props =>
      [
        id,
        day,
        status,
        paymentMethod,
        userId,
        userAddressId,
        cartId,
        intervalHoursId,
        userAddress,
        user,
        intervalHour,
        subCarts,
        subTotal,
        total,
        shippingFee,
        couponName,
        couponValue,
        couponType,
      ];

  factory OrdersDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersDataModelToJson(this);
}

@JsonSerializable()
class IntervalHourModel extends Equatable {
  final DayModel? day;
  final String? to;
  final String? from;
  final int? id;

  const IntervalHourModel({
    this.day,
    this.to,
    this.from,
    this.id,
  });

  @override
  List<Object?> get props => [day, to, from, id];

  factory IntervalHourModel.fromJson(Map<String, dynamic> json) =>
      _$IntervalHourModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalHourModelToJson(this);
}

@JsonSerializable()
class DayModel extends Equatable {
  final String? name;
  final int? id;

  const DayModel({
    this.name,
    this.id,
  });

  @override
  List<Object?> get props => [name, id];

  factory DayModel.fromJson(Map<String, dynamic> json) =>
      _$DayModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayModelToJson(this);
}

// @JsonSerializable()
// class SubCartModel extends Equatable {
//   @JsonKey(name: "dynamic_variant_carts")
//   final List<DynamicVariantCartModel>? dynamicVariantCarts;
//   final ProductModel? product;
//   final int? amount;
//   @JsonKey(name: "product_id")
//   final int? productId;
//   final int? id;
//
//   const SubCartModel({
//     this.dynamicVariantCarts,
//     this.product,
//     this.amount,
//     this.productId,
//     this.id,
//   });
//
//   @override
//   List<Object?> get props =>
//       [
//         dynamicVariantCarts,
//         product,
//         amount,
//         productId,
//         id,
//       ];
//
//   factory SubCartModel.fromJson(Map<String, dynamic> json) =>
//       _$SubCartModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SubCartModelToJson(this);
// }

@JsonSerializable()
class DynamicVariantCartModel extends Equatable {
  @JsonKey(name: "dynamic_variant")
  final DynamicVariantModel? dynamicVariant;
  final int? amount;
  @JsonKey(name: "dynamic_variant_id")
  final int? dynamicVariantId;
  final int? id;

  const DynamicVariantCartModel({
    this.dynamicVariant,
    this.amount,
    this.dynamicVariantId,
    this.id,
  });

  @override
  List<Object?> get props => [dynamicVariant, amount, dynamicVariantId, id];

  factory DynamicVariantCartModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicVariantCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantCartModelToJson(this);
}

@JsonSerializable()
class DynamicVariantModel extends Equatable {
  @JsonKey(name: "category_id")
  final int? categoryId;
  final int? price;
  @JsonKey(name: "has_amount")
  final bool? hasAmount;
  @JsonKey(name: "available_amount")
  final int? availableAmount;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEn;
  final int? id;

  const DynamicVariantModel({
    this.categoryId,
    this.price,
    this.hasAmount,
    this.availableAmount,
    this.nameAr,
    this.nameEn,
    this.id,
  });

  @override
  List<Object?> get props =>
      [
        categoryId,
        price,
        hasAmount,
        availableAmount,
        nameAr,
        nameEn,
        id,
      ];

  factory DynamicVariantModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantModelToJson(this);
}

@JsonSerializable()
class BrandModel extends Equatable {
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEn;

const  BrandModel(this.nameAr, this.nameEn);

  @override
  List<Object?> get props => [nameAr, nameEn];
  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}
@JsonSerializable()
class ImageModel extends Equatable {
  final String? url;
  final int? id;

const  ImageModel(this.url, this.id);

  @override
  List<Object?> get props => [url, id];
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class ProductModel extends Equatable {
  final BrandModel? brand;
  @JsonKey(name: "sub_category")
  final BrandModel? subCategory;
  final List<ImageModel>? images;
  @JsonKey(name: "brand_id")
  final int? brandId;
  @JsonKey(name: "sub_category_id")
  final int? subCategoryId;
  @JsonKey(name: "category_id")
  final int? categoryId;
  final bool? isDeleted;
  final int? weight;
  final double? offerPrice;
  final bool? offer;
  final bool? newIn;
  final bool? bestSeller;
  final int? amount;
  final String? code;
  @JsonKey(name: "description_ar")
  final String? descriptionAr;
  @JsonKey(name: "description_en")
  final String? descriptionEn;
  final double? price;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEn;
  final int? id;

  const ProductModel({
    this.brandId,
    this.subCategoryId,
    this.categoryId,
    this.isDeleted,
    this.weight,
    this.offerPrice,
    this.offer,
    this.newIn,
    this.bestSeller,
    this.amount,
    this.code,
    this.descriptionAr,
    this.descriptionEn,
    this.price,
    this.nameAr,
    this.nameEn,
    this.id,
    this.brand,
    this.subCategory,
    this.images
  });

  @override
  List<Object?> get props =>
      [
        brandId,
        subCategoryId,
        categoryId,
        isDeleted,
        weight,
        offerPrice,
        offer,
        newIn,
        bestSeller,
        amount,
        code,
        descriptionAr,
        descriptionEn,
        price,
        nameAr,
        nameEn,
        id,
        brand,
        subCategory,
        images
      ];

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class UserModel extends Equatable {
  final String? phone;
  @JsonKey(name: "country_code")
  final String? countryCode;
  final String? email;
  @JsonKey(name: "l_name")
  final String? lName;
  @JsonKey(name: "f_name")
  final String? fName;
  final int? id;

  const UserModel({
    this.phone,
    this.countryCode,
    this.email,
    this.lName,
    this.fName,
    this.id,
  });

  @override
  List<Object?> get props => [phone, countryCode, email, lName, fName, id];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserAddressModel extends Equatable {
  final String? phone;
  @JsonKey(name: "country_code")
  final String? countryCode;
  @JsonKey(name: "area_id")
  final int? areaId;
  @JsonKey(name: "country_id")
  final int? countryId;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "is_default")
  final bool? isDefault;
  final double? latitude;
  final double? longitude;
  final String? otherInstructions;
  final int? aptNumber;
  final String? houseNumber;
  final int? officeNumber;
  final int? floorNumber;
  final int? buildingNumber;
  final String? type;
  final String? avenue;
  final String? street;
  final String? block;
  final String? addressName;
  final int? id;

  const UserAddressModel({
    this.phone,
    this.countryCode,
    this.areaId,
    this.countryId,
    this.userId,
    this.isDefault,
    this.latitude,
    this.longitude,
    this.otherInstructions,
    this.aptNumber,
    this.houseNumber,
    this.officeNumber,
    this.floorNumber,
    this.buildingNumber,
    this.type,
    this.avenue,
    this.street,
    this.block,
    this.addressName,
    this.id,
  });

  @override
  List<Object?> get props =>
      [
        phone,
        countryCode,
        areaId,
        countryId,
        userId,
        isDefault,
        latitude,
        longitude,
        otherInstructions,
        aptNumber,
        houseNumber,
        officeNumber,
        floorNumber,
        buildingNumber,
        type,
        avenue,
        street,
        block,
        addressName,
        id,
      ];

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressModelToJson(this);
}
