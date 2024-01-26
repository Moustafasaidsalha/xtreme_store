import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:extreme_store/data/models/wishlist.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';

class DeleteWishlistItemUseCase
    implements UseCase<ResponseModel, DeleteWishlistItemParams> {
  final BaseRepository baseRepository;

  DeleteWishlistItemUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, ResponseModel>> call(DeleteWishlistItemParams params) async {
    return await baseRepository.deleteWishlistItem(
        params: params);
  }
}

class DeleteWishlistItemParams extends Equatable {
  final ProductIdModel productID;
  final String token;

  @override
  List<Object?> get props => [productID, token];

  const DeleteWishlistItemParams({
    required this.productID,
    required this.token,
  });
}