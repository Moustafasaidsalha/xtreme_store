import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'local_data_base.g.dart';

class CartTable extends Table {
  IntColumn get id => integer().named("ID").autoIncrement()();
  IntColumn get productID => integer().named("productID")();
  IntColumn get amount => integer().named("amount")();

  @override
  Set<Column> get primaryKey => {id};
}

class DynamicVariantsTable extends Table {
  IntColumn get id => integer().named("ID").autoIncrement()();
  IntColumn get dynamicVariantsID => integer().named("dynamicVariantsID")();
  IntColumn get amount => integer().named("amount")();
  IntColumn get productID => integer().named("productID").nullable().references(CartTable, #productID)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [CartTable,DynamicVariantsTable])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'local.db'));
    if (kDebugMode) {
      print(dbFolder);
    }
    return NativeDatabase.createInBackground(file);
  });
}
