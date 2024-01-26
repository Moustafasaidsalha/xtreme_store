import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/product.dart';

import '../repositories/base_repository.dart';

class GetChangeOfProductDetailsUseCase implements UseCase<ProductDetailsModel,GetChangeOfProductDetailsParams> {
  final BaseRepository baseRepository;

  GetChangeOfProductDetailsUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, ProductDetailsModel>> call(GetChangeOfProductDetailsParams params
      ) async {
    return await baseRepository.getChangeOfProductDetails(
        params: params  );
  }
}

class GetChangeOfProductDetailsParams extends Equatable{
  final  int productCode;
  final List<String> variantValueIds;
  const GetChangeOfProductDetailsParams({
    required this.productCode,
    required this.variantValueIds,
  });

  @override
  List<Object?> get props => [productCode,variantValueIds];


}