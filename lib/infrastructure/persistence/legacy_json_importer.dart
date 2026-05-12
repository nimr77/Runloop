import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';

/// One-time import from pre-SQLite `collections.json` into Drift.
class LegacyJsonImporter {
  static Future<void> maybeImport(AppDatabase db) async {
    final existing = await db.select(db.dbCollections).get();
    if (existing.isNotEmpty) return;

    final base = await getApplicationSupportDirectory();
    final jsonFile = File(p.join(base.path, 'runloop', 'collections.json'));
    if (!await jsonFile.exists()) return;

    final text = await jsonFile.readAsString();
    if (text.trim().isEmpty) return;
    final list = jsonDecode(text) as List<dynamic>;

    await db.transaction(() async {
      for (final e in list) {
        final m = e as Map<String, dynamic>;
        final id = m['id'] as String;
        final name = m['name'] as String;
        final cmds = (m['commands'] as List<dynamic>).cast<String>();
        final auto = m['autoRunOnAppStart'] as bool? ?? false;

        await db.into(db.dbCollections).insert(
              DbCollectionsCompanion.insert(
                id: id,
                name: name,
                autoRunOnAppStart: Value(auto),
              ),
            );
        for (var i = 0; i < cmds.length; i++) {
          await db.into(db.dbCollectionCommands).insert(
                DbCollectionCommandsCompanion.insert(
                  collectionId: id,
                  sortOrder: i,
                  line: cmds[i],
                ),
              );
        }
      }
    });

    await jsonFile.rename('${jsonFile.path}.migrated');
  }
}
