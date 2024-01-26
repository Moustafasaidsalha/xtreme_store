import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/sub_category.dart';
import 'package:extreme_store/domain/repositories/base_repository.dart';

class GetSubCategoriesOfCategoryUseCase
    implements UseCase<SubCategoriesModel, GetSubCategoriesOfCategoryParams> {
  final BaseRepository baseRepository;

  GetSubCategoriesOfCategoryUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, SubCategoriesModel>> call(GetSubCategoriesOfCategoryParams params) async {
    return await baseRepository.getSubCategoryOfCategory(
      params: params

    );
  }
}

class GetSubCategoriesOfCategoryParams extends Equatable {
  final int offset;
  final int limit;
  final int categoryId;


  @override
  List<Object> get props => [offset, limit, categoryId];

  const GetSubCategoriesOfCategoryParams({
    required this.offset,
    required this.limit,
    required this.categoryId,
  });
}