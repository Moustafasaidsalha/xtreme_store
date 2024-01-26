import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:extreme_store/data/models/product.dart';

import '../repositories/base_repository.dart';

class GetProductsUseCase implements UseCase<ProductsModel,GetProductsParams>{
  final BaseRepository baseRepository;

  GetProductsUseCase({required this.baseRepository});

  @override
  Future<Either<Failure, ProductsModel>> call(GetProductsParams params) async {
    return await baseRepository.getProducts(
        params: params
    );
  }
}

class GetProductsParams extends Equatable {
  final int offset;
  final int limit;
  final bool bestSeller;
  final bool newIn;
  final bool offer;
  final int? categoryId;
  final int? subCategoryId;
  final int? brandId;


  @override
  List<Object> get props => [offset, limit, bestSeller, newIn, offer];

  const GetProductsParams({
    required this.offset,
    required this.limit,
    required this.bestSeller,
    required this.newIn,
    required this.offer,
     this.categoryId,
     this.subCategoryId,
     this.brandId,
  });

}