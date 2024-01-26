import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/constants/strings_constants.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/data_source/local/dynamic_variants_dao.dart';
import 'package:extreme_store/data/models/add_to_cart_body.dart';
import 'package:extreme_store/data/models/response.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../../data/data_source/local/local_data_base.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class AddToCart implements UseCase<ResponseModel, AddToCartParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final DynamicVariantsDao dynamicVariantsDao;
  final UserPreferenceRepo userPreferenceRepo;

  AddToCart({
    required this.baseRepository,
    required this.cartDao,
    required this.dynamicVariantsDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(
    AddToCartParams params,
  ) async {
    /// Add cart - offline
    /// - get list of products
    /// - with amounts
    /// - get list of dynamic variants
    /// solved - as one product sent in request

    final token = userPreferenceRepo.getAccessToken();
    if (token.isEmpty) {
      List<Products> products = params.addToCartBody?.products ?? [];
      if (products.isNotEmpty) {
        var p = params.addToCartBody?.products?.first;
        final res = await cartDao.getALlCart();
        bool isProductFound = res.any((d) => d.productID == (p?.productId ?? 0));
        if (isProductFound) {
          return const Left(ServerFailure(StringsConstants.productExistInCart));
        } else {
          final res = await cartDao.insertProductToCart(
            cartItem: CartTableCompanion(
              productID: Value(p?.productId ?? 0),
              amount: Value(p?.amount ?? 0),
            ),
          );
          return res.fold(
            (l) => Left(ServerFailure(l.message)),
            (r) async {
              /// is r the productID?

              if (p?.dynamicVariant?.isNotEmpty ?? false) {
                for (var x in p!.dynamicVariant!) {
                  await dynamicVariantsDao.insertDynamicVariants(
                    dynamicVariantsTableCompanion: DynamicVariantsTableCompanion(
                      productID: Value(p.productId),
                      dynamicVariantsID: Value(x.dynamicVariantId ?? 0),
                      amount: Value(x.amount ?? 0),
                    ),
                  );
                }
              }

              return const Right(
                ResponseModel(
                  StringsConstants.theOperationCompletedSuccessfully,
                  200,
                  true,
                ),
              );
            },
          );
        }
      } else {
        return const Left(ServerFailure(StringsConstants.someThingWrong));
      }
    } else {
      /// Add cart - Online
      final res = await baseRepository.addToCart(
        body: params.addToCartBody!,
      );
      return res.fold(
        (l) => Left(ServerFailure(l.message)),
        (r) => Right(r),
      );
    }
  }
}

class AddToCartParams extends Equatable {
  final AddToCartBody? addToCartBody;

  const AddToCartParams({
    this.addToCartBody,
  });

  @override
  List<Object?> get props => [addToCartBody];
}
