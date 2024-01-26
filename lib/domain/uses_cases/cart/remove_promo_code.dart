import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/models/response.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class RemovePromoCode implements UseCase<ResponseModel, RemovePromoCodeParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final UserPreferenceRepo userPreferenceRepo;

  RemovePromoCode({
    required this.baseRepository,
    required this.cartDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(
      RemovePromoCodeParams params,
  ) async {
      final res = await baseRepository.removePromoCode(
        cartID: params.cartID,
      );
      return res.fold(
        (l) => Left(l),
        (r) => Right(r),
      );

  }
}

class RemovePromoCodeParams extends Equatable {
  final int cartID;

  const RemovePromoCodeParams({
    required this.cartID,
  });

  @override
  List<Object?> get props => [cartID];
}
