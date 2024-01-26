import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/models/response.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class ChangeProductCartAmount
    implements UseCase<ResponseModel, ChangeProductCartAmountParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final UserPreferenceRepo userPreferenceRepo;

  ChangeProductCartAmount({
    required this.baseRepository,
    required this.cartDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(
    ChangeProductCartAmountParams params,
  ) async {
    final token = userPreferenceRepo.getAccessToken();
    if (token.isEmpty) {
      print('I am in cart local ${params.productID} amount ${params.amount}');
      final res = await cartDao.updateProductAmount(
          id: params.productID, amount: params.amount);
      print(res);
      print("????/????????????????????");
      return res.fold(
        (l) => Left(ServerFailure(l.message)),
        (r) => const Right(ResponseModel("Success", 200, true)),
      );
    } else {
      final res = await baseRepository.changeProductCartAmount(
        productID: params.productID,
        amount: params.amount,
      );
      return res.fold(
        (l) => Left(ServerFailure(l.message)),
        (r) => Right(r),
      );
    }
  }
}

class ChangeProductCartAmountParams extends Equatable {
  final int productID;
  final int amount;

  const ChangeProductCartAmountParams({
    required this.productID,
    required this.amount,
  });

  @override
  List<Object?> get props => [productID, amount];
}
