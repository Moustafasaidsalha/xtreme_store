import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';

import 'package:extreme_store/data/models/variant.dart';

import '../repositories/base_repository.dart';

class GetVariantsUseCase  implements UseCase<VariantModel,GetVariantsParams>{
  final BaseRepository baseRepository;

  GetVariantsUseCase ({required this.baseRepository});

  @override
  Future<Either<Failure, VariantModel>> call(GetVariantsParams params
       ) async {
    return await baseRepository.getVariants( params:params);
  }
}
class GetVariantsParams extends Equatable {
  final int categoryId;

  const GetVariantsParams({
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryId];
}