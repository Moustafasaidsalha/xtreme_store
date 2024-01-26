import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/category.dart';

import '../repositories/base_repository.dart';

class GetCategoriesUseCase implements UseCase
<CategoriesModel,GetCategoriesParams> {
final BaseRepository baseRepository;


@override
  Future<Either<Failure, CategoriesModel>> call(GetCategoriesParams params
) async {
return await baseRepository.getCategories(
    params:params );
}

const GetCategoriesUseCase({
    required this.baseRepository,
  });
}
class GetCategoriesParams extends Equatable {
  final int offset;
  final int limit;

  const GetCategoriesParams({
    required this.offset,
    required this.limit,
  });

  @override
  List<Object> get props => [offset, limit];

}