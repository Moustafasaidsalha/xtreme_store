import 'package:dartz/dartz.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/data_source/local/dynamic_variants_dao.dart';
import 'package:extreme_store/data/models/add_to_cart_body.dart';
import 'package:extreme_store/data/models/response.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class MigrateLocalCartToOnline implements UseCase<ResponseModel, NoParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final DynamicVariantsDao dynamicVariantsDao;
  final UserPreferenceRepo userPreferenceRepo;

  MigrateLocalCartToOnline({
    required this.baseRepository,
    required this.cartDao,
    required this.dynamicVariantsDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(NoParams params) async {
    final token = userPreferenceRepo.getAccessToken();
    if (token.isEmpty) {
      return const Left(DataFailure());
    } else {
      List<Products> listOfLocalProducts = [];
      final resP = await cartDao.getALlCart();
      if (resP.isNotEmpty) {
        for (var i in resP) {
          final resDV = await dynamicVariantsDao.getALlDynamicVariantsForProduct(productID: i.productID);
          List<DynamicVariant> dynamicVariant =
              resDV.map((e) => DynamicVariant(dynamicVariantId: e.dynamicVariantsID, amount: e.amount)).toList();
          listOfLocalProducts.add(Products(
            productId: i.productID,
            amount: i.amount,
            dynamicVariant: dynamicVariant,
          ));
        }
        final res = await baseRepository.addToCart(
          body: AddToCartBody(products: listOfLocalProducts),
        );
        /// - to ensure having no issues
        await dynamicVariantsDao.deleteEntryTable();
        await cartDao.deleteEntryTable();
        // if (res.isRight()) {
        //   await dynamicVariantsDao.deleteEntryTable();
        //   await cartDao.deleteEntryTable();
        // }
        return res.fold((l) => Left(l), (r) => Right(r));
      } else {
        return const Right(ResponseModel("Success", 200, true));
      }
    }
  }
}
