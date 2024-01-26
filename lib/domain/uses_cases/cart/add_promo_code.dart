import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/data/data_source/local/cart_dao.dart';
import 'package:extreme_store/data/models/promo_code_response_model.dart';

import '../../../app/failure/failure.dart';
import '../../../app/use_case/use_case.dart';
import '../../repositories/base_repository.dart';
import '../../repositories/user_preference_repo.dart';

class AddPromoCode implements UseCase<PromoCodeResponseModel, AddPromoCodeParams> {
  final BaseRepository baseRepository;
  final CartDao cartDao;
  final UserPreferenceRepo userPreferenceRepo;

  AddPromoCode({
    required this.baseRepository,
    required this.cartDao,
    required this.userPreferenceRepo,
  });

  @override
  Future<Either<Failure, PromoCodeResponseModel>> call(
    AddPromoCodeParams params,
  ) async {
      final res = await baseRepository.addPromoCode(
        cartID: params.cartID,
        promoCodeName: params.promoCodeName,
      );
      return res.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
  }
}

class AddPromoCodeParams extends Equatable {
  final String promoCodeName;
  final int cartID;

  const AddPromoCodeParams({
    required this.promoCodeName,
    required this.cartID,
  });

  @override
  List<Object?> get props => [cartID, promoCodeName];
}
