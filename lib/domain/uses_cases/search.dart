import 'package:equatable/equatable.dart';
import 'package:extreme_store/app/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/models/product.dart';

import '../repositories/base_repository.dart';

class SearchUseCase implements UseCase<ProductsModel, SearchParams> {
  final BaseRepository baseRepository;

  SearchUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, ProductsModel>> call(
      SearchParams params) async {
    return await baseRepository.search(
        params: params);
  }
}

class SearchParams extends Equatable {


  final int offset;
  final int limit;
  final String? name;
  final bool bestSeller;
  final bool newIn;
  final bool offer;
  final int? categoryId;
  final int? subCategoryId;
  final String? sortBy;

  const SearchParams({
    required this.offset,
    required this.limit,
    this.name,
    required this.bestSeller,
    required this.newIn,
    required this.offer,
    this.categoryId,
    this.subCategoryId,
    this.sortBy,
  });

  @override
  List<Object?> get props =>
      [
        offset,
        limit,
        name,
        bestSeller,
        newIn,
        offer,
        categoryId,
        subCategoryId,
        sortBy,
      ];
}