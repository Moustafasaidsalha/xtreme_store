import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/wishlist.dart';

import '../repositories/base_repository.dart';

class GetWishlistsUseCase implements UseCase<WishlistsModel,GetWishlistsParams> {
  final BaseRepository baseRepository;

  GetWishlistsUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, WishlistsModel>> call(
      GetWishlistsParams params      ) async {
    return await baseRepository.getWishlists(params:params);
  }
}
class GetWishlistsParams extends Equatable{
  final  String token;
  final  int offset;
  final int limit;
  const GetWishlistsParams({
    required this.offset,
    required this.limit,
    required this.token,
  });

  @override
  List<Object?> get props => [offset,limit,token];


}