import 'package:drift/drift.dart';

import '../../domain/entities/command_collection.dart';
import '../../domain/repositories/command_collection_repository.dart';
import '../database/app_database.dart';

class DriftCommandCollectionRepository implements CommandCollectionRepository {
  DriftCommandCollectionRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<CommandCollection>> loadAll() async {
    final cols = await _db.select(_db.dbCollections).get();
    final out = <CommandCollection>[];
    for (final c in cols) {
      final cmds = await (_db.select(_db.dbCollectionCommands)
            ..where((t) => t.collectionId.equals(c.id))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
      out.add(
        CommandCollection(
          id: c.id,
          name: c.name,
          autoRunOnAppStart: c.autoRunOnAppStart,
          commands: cmds.map((e) => e.line).toList(),
        ),
      );
    }
    return out;
  }

  @override
  Future<void> save(CommandCollection collection) async {
    await _db.transaction(() async {
      await _db.into(_db.dbCollections).insertOnConflictUpdate(
            DbCollectionsCompanion(
              id: Value(collection.id),
              name: Value(collection.name),
              autoRunOnAppStart: Value(collection.autoRunOnAppStart),
            ),
          );
      await (_db.delete(_db.dbCollectionCommands)
            ..where((t) => t.collectionId.equals(collection.id)))
          .go();
      for (var i = 0; i < collection.commands.length; i++) {
        await _db.into(_db.dbCollectionCommands).insert(
              DbCollectionCommandsCompanion.insert(
                collectionId: collection.id,
                sortOrder: i,
                line: collection.commands[i],
              ),
            );
      }
    });
  }

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.dbCollections)..where((t) => t.id.equals(id))).go();
  }
}
