import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/brand.dart';

import '../repositories/base_repository.dart';

class GetBrandsUseCase implements UseCase<BrandsModel,GetBrandsParams> {
  final BaseRepository baseRepository;

  GetBrandsUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, BrandsModel>> call(GetBrandsParams params

      ) async {
    return await baseRepository.getBrands(
        params: params   );
  }
}
class GetBrandsParams extends Equatable{
  final  int offset;
  final int limit;
  const GetBrandsParams({
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => [offset,limit];


}