import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:extreme_store/data/data_source/local/local_data_base.dart';

import '../../../app/failure/failure.dart';

part 'cart_dao.g.dart';

@DriftAccessor(tables: [CartTable])
class CartDao extends DatabaseAccessor<LocalDatabase> with _$CartDaoMixin {
  CartDao(LocalDatabase db) : super(db);

  Future<List<CartTableData>> getALlCart() async {
    return await select(cartTable).get();
  }

  Stream<List<CartTableData>> getCart() {
    return select(cartTable).watch();
  }

  Future<Either<Failure, int>> insertProductToCart({
    required CartTableCompanion cartItem,
  }) async {
    try {
      int id = await into(cartTable).insert(cartItem);
      return Right(id);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const Left(ServerFailure("error"));
    }
  }

  Future<Either<Failure, bool>> updateProductAmount({
    required int id,
    required int amount,
  }) async {
    try {
      await (update(cartTable)..where((t) => t.productID.equals(id))).write(
        CartTableCompanion(
          amount: Value(amount),
        ),
      );

      return const Right(true);
    } on Exception catch (_) {
      return const Left(ServerFailure('Error'));
    }
  }

  Future<Either<Failure, bool>> deleteItem({
    required int productID,
  }) async {
    try {
      print(" in dao $productID");
      final x = await (delete(cartTable)..where((t) => t.productID.equals(productID))).go();
      print(x);
      print("in dao delete");
      return const Right(true);
    } on Exception catch (_) {
      return const Left(ServerFailure("error"));
    }
  }

  Future<Either<Failure, bool>> deleteEntryTable() async {
    try {
      await (delete(cartTable)).go();
      return const Right(true);
    } on Exception catch (_) {
      return const Left(ServerFailure("error"));
    }
  }
}
