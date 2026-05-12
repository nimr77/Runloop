import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class DbCollections extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get autoRunOnAppStart =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DbCollectionCommands extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectionId => text().references(DbCollections, #id,
      onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer()();
  TextColumn get line => text()();
}

class DbAppPrefs extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get launchAtLogin =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final dbDir = Directory(p.join(dir.path, 'runloop'));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }
    final file = File(p.join(dbDir.path, 'runloop.db'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [DbCollections, DbCollectionCommands, DbAppPrefs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
