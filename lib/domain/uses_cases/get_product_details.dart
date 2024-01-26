import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/product.dart';

import '../repositories/base_repository.dart';

class GetProductDetailsUseCase implements UseCase<ProductDetailsModel, GetProductDetailsParams> {
  final BaseRepository baseRepository;

  GetProductDetailsUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, ProductDetailsModel>> call(GetProductDetailsParams params) async {
    return await baseRepository.getProductDetails(params: params);
  }
}

class GetProductDetailsParams extends Equatable {
  final int productId;
  const GetProductDetailsParams({
    required this.productId,
  });

  @override
  List<Object?> get props => [productId];
}
