import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/sub_category.dart';

import '../repositories/base_repository.dart';

class GetSubCategoriesUseCase implements UseCase<SubCategoriesModel,NoParams> {
  final BaseRepository baseRepository;

  GetSubCategoriesUseCase({required this.baseRepository});
  @override
  Future<Either<Failure, SubCategoriesModel>> call(NoParams noParams

      ) async {
    return await baseRepository.getSubCategories(

    );
  }
}
