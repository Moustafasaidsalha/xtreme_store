import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/data_source/local/dynamic_variants_dao.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class DeleteFromCart implements UseCase<bool, DeleteFromCartParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final DynamicVariantsDao dynamicVariantsDao;
  final UserPreferenceRepo userPreferenceRepo;

  DeleteFromCart({
    required this.baseRepository,
    required this.cartDao,
    required this.dynamicVariantsDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, bool>> call(
    DeleteFromCartParams params,
  ) async {
    final token = userPreferenceRepo.getAccessToken();
    if (token.isEmpty) {
      if (kDebugMode) {
        print("in delete from cart online ${params.productID}");
      }

      final res = await dynamicVariantsDao.deleteAllProductVariants(productID: params.productID);
      return res.fold((l) => Left(ServerFailure(l.message)), (r) async {
        return await cartDao.deleteItem(productID: params.productID);
      });
    } else {
      if (kDebugMode) {
        print("in delete from cart online ${params.productID}");
      }
      final res = await baseRepository.deleteFromCart(
        productID: params.productID,
      );
      return res.fold(
        (l) => Left(ServerFailure(l.message)),
        (r) => const Right(true),
      );
    }
  }
}

class DeleteFromCartParams extends Equatable {
  final int productID;

  const DeleteFromCartParams({
    required this.productID,
  });

  @override
  List<Object?> get props => [productID];
}
