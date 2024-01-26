// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:extreme_store/app/failure/failure.dart';
// import 'package:extreme_store/app/use_case/use_case.dart';
// import 'package:extreme_store/data/models/promo_code_response_model.dart';
//
// import '../repositories/base_repository.dart';
//
// class AddPromoCode implements UseCase<PromoCodeResponseModel, AddPromoCodeParams> {
//   final BaseRepository baseRepository;
//
//   AddPromoCode({required this.baseRepository});
//
//   @override
//   Future<Either<Failure, PromoCodeResponseModel>> call(
//     AddPromoCodeParams params,
//   ) async {
//     return await baseRepository.addPromoCode(
//       cartID: params.cartID,
//       promoCodeName: params.promoCardName,
//     );
//   }
// }
//
// class AddPromoCodeParams extends Equatable {
//   final int cartID;
//   final String promoCardName;
//
//   const AddPromoCodeParams({
//     required this.promoCardName,
//     required this.cartID,
//   });
//
//   @override
//   List<Object> get props => [cartID, promoCardName];
// }
