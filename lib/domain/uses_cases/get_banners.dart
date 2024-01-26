import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/banner.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';

import '../repositories/base_repository.dart';

class GetBannersUseCase implements UseCase<BannersModel,GetBannersParams> {
  final BaseRepository baseRepository;

  GetBannersUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, BannersModel>> call(GetBannersParams params

      ) async {
    return await baseRepository.getBanners(
       params: params   );
  }
}
class GetBannersParams extends Equatable{
 final  int offset;
   final int limit;
   const GetBannersParams({
     required this.offset,
     required this.limit,
   });

   @override
  List<Object?> get props => [offset,limit];


}