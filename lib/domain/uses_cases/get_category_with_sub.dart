import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/category_with_sub.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';

class GetCategoryWithSubsUseCase implements UseCase
<CategoriesWithSubsModel,GetCategoryWithSubsParams> {
  final BaseRepository baseRepository;


  @override
  Future<Either<Failure, CategoriesWithSubsModel>> call(GetCategoryWithSubsParams params
      ) async {
    return await baseRepository.getCategoryWithSub(
        params:params );
  }

  const GetCategoryWithSubsUseCase({
    required this.baseRepository,
  });
}
class GetCategoryWithSubsParams extends Equatable {
  final int offset;
  final int limit;

  const GetCategoryWithSubsParams({
    required this.offset,
    required this.limit,
  });

  @override
  List<Object> get props => [offset, limit];

}