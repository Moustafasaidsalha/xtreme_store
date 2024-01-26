import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';

class SetWishlistItemUseCase
    implements UseCase<ResponseModel, SetWishlistItemParams> {
  final BaseRepository baseRepository;

  SetWishlistItemUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(SetWishlistItemParams params) async {
    return await baseRepository.setWishlistItem(
        params: params);
  }
}

class SetWishlistItemParams extends Equatable {
  final ProductIdModel productID;
  final String token;

  @override
  List<Object?> get props => [id, token];

  const SetWishlistItemParams({
    required this.productID,
    required this.token,
  });
}