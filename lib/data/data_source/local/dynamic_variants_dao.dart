import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:extreme_store/data/data_source/local/local_data_base.dart';

import '../../../app/failure/failure.dart';
part 'dynamic_variants_dao.g.dart';

@DriftAccessor(tables: [DynamicVariantsTable])
class DynamicVariantsDao extends DatabaseAccessor<LocalDatabase> with _$DynamicVariantsDaoMixin {
  DynamicVariantsDao(LocalDatabase db) : super(db);

  Future<Either<Failure, List<DynamicVariantsTableData>>> getALlDynamicVariantsByProductID({
    required int productID,
  }) async {
    try {
      final res = await (select(dynamicVariantsTable)
            ..where((items) {
              return items.productID.equals(productID);
            }))
          .get();
      if (res.isNotEmpty) {
        return Right(res);
      } else {
        return const Right([]);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const Left(ServerFailure("Error"));
    }
  }

  Future<List<DynamicVariantsTableData>> getALlDynamicVariantsForProduct({
    required int productID,
  }) async {
    try {
      final res = await (select(dynamicVariantsTable)
            ..where((items) {
              return items.productID.equals(productID);
            }))
          .get();
      if (res.isNotEmpty) {
        return res;
      } else {
        return [];
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<Either<Failure, int>> insertDynamicVariants({
    required DynamicVariantsTableCompanion dynamicVariantsTableCompanion,
  }) async {
    try {
      int id = await into(dynamicVariantsTable).insert(dynamicVariantsTableCompanion);
      return Right(id);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const Left(ServerFailure("error"));
    }
  }

  Future<Either<Failure, bool>> deleteAllProductVariants({
    required int productID,
  }) async {
    try {
      await (delete(dynamicVariantsTable)..where((t) => t.productID.equals(productID))).go();
      return const Right(true);
    } on Exception catch (_) {
      return const Left(ServerFailure("error"));
    }
  }

  Future<Either<Failure, bool>> deleteItemByDVID({
    required int dynamicVariantsID,
  }) async {
    try {
      await (delete(dynamicVariantsTable)..where((t) => t.dynamicVariantsID.equals(dynamicVariantsID))).go();
      return const Right(true);
    } on Exception catch (_) {
      return const Left(ServerFailure("error"));
    }
  }

  Future<Either<Failure, bool>> deleteEntryTable() async {
    try {
      await (delete(dynamicVariantsTable)).go();
      return const Right(true);
    } on Exception catch (_) {
      return const Left(ServerFailure("error"));
    }
  }
}
