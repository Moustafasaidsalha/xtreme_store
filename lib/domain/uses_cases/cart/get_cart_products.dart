import 'package:dartz/dartz.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/models/cart_response_model.dart';
import 'package:extreme_store/domain/entity/cart_entity.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../../data/models/add_to_cart_body.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class GetCartProducts implements UseCase<CartEntity, NoParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final UserPreferenceRepo userPreferenceRepo;

  GetCartProducts({
    required this.baseRepository,
    required this.cartDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, CartEntity>> call(
    NoParams params,
  ) async {
    final token = userPreferenceRepo.getAccessToken();
    if (token.isEmpty) {
      final res = await cartDao.getALlCart();

      List<Products> products = res
          .map((e) {
            print(e);
            return Products(
              amount: e.amount,
              productId: e.productID,
            );
      })
          .toList();

      if (res.isNotEmpty) {
        final dataResponse = await baseRepository.getLocalCart(
          body: AddToCartLocalBody(products: products),
        );

        return dataResponse.fold((l) {
          return Left(ServerFailure(l.message));
        }, (r) {
          List<SubCarts> subCarts = r.data?.localProducts
                  ?.map((e) => SubCarts(
                      productId: res.firstWhere((element) => element.productID == e.id).productID,
                      product: e,
                      amount: res.firstWhere((element) => element.productID == e.id).amount))
                  .toList() ??
              [];

          return Right(CartEntity(
            total: r.data?.subTotal ?? 0,
            currency: r.data?.currencyType ?? '',
            subTotal: r.data?.subTotal ?? 0,
            products: subCarts,
          ));
        });
      } else {
        return const Right(
          CartEntity(
            products: [],
            subTotal: 0,
            shippingFees: 0,
            total: 0,
            coupon: 0,
          ),
        );
      }
      // double total = 0;
      // List<ProductModel> products = res.map((c) {
      //   return ProductModel(
      //     id: c.productID,
      //     nameAr: c.nameAR,
      //     nameEn: c.nameEN,
      //     brand: BrandModel(c.brandNameEN, c.brandNameAR),
      //     price: c.price,
      //     code: c.code,
      //     amount: c.amount,
      //     images: [
      //       ImageModel(c.image, 0),
      //     ],
      //     offerPrice: c.offerPrice,
      //   );
      // }).toList();
      // for (var p in res) {
      //   if (p.offerPrice > 0) {
      //     total += p.offerPrice;
      //   } else {
      //     total += p.price;
      //   }
      // }
      //
      // return Right(CartEntity(
      //   products: const [],
      //   total: total,
      //   subTotal: total,
      //   coupon: 0,
      //   shippingFees: 0,
      // ));
      // return const Left(ServerFailure(""));
    } else {
      final res = await baseRepository.getCart();
      return res.fold((l) => Left(l), (r) {
        if (r.data?.subCarts?.isNotEmpty ?? false) {
          // List<ProductModel> products = r.data?.subCarts!.data!.map((c) {
          //   return ProductModel(
          //     id: c.productModel?.id ?? 0,
          //     nameAr: c.productModel?.nameAr ?? '',
          //     nameEn: c.productModel?.nameEn ?? '',
          //     brand: c.productModel?.brand,
          //     price: c.productModel?.price,
          //     code: c.productModel?.code,
          //     amount: c.productModel?.amount,
          //     images: c.productModel?.images,
          //     offerPrice: c.productModel?.offerPrice,
          //   );
          // }).toList();
          return Right(CartEntity(
            cartID: r.data?.id ?? 0,
            products: r.data?.subCarts ?? [],
            total: r.data?.total ?? 0,
            shippingFees: r.data?.shippingFee ?? 0,
            subTotal: r.data?.subTotal ?? 0,
            coupon: r.data?.discountAmount ?? 0,
            currency: r.data?.currencyType ?? '',
            couponName: r.data?.couponName ?? '',
          ));
        } else {
          return const Right(
            CartEntity(
              products: [],
              subTotal: 0,
              shippingFees: 0,
              total: 0,
              coupon: 0,
            ),
          );
        }
      });
    }
  }
}
