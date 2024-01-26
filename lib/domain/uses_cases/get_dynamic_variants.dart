import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/dynamic_variants.dart';

import '../repositories/base_repository.dart';

class GetProductDynamicVariantsDetailsUseCase implements UseCase<DynamicVariantsModel,GetDynamicVariantsProductDetailsParams> {
  final BaseRepository baseRepository;

  GetProductDynamicVariantsDetailsUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, DynamicVariantsModel>> call(GetDynamicVariantsProductDetailsParams params
      ) async {
    return await baseRepository.getProductDynamicVariantsDetails(
        params: params  );
  }
}

class GetDynamicVariantsProductDetailsParams extends Equatable{
  final  int productId;
  const GetDynamicVariantsProductDetailsParams({
    required this.productId,
  });

  @override
  List<Object?> get props => [productId];


}