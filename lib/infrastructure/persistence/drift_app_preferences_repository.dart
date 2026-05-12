import 'package:drift/drift.dart';

import '../../domain/repositories/app_preferences_repository.dart';
import '../database/app_database.dart';

class DriftAppPreferencesRepository implements AppPreferencesRepository {
  DriftAppPreferencesRepository(this._db);

  final AppDatabase _db;

  @override
  Future<bool> getLaunchAtLogin() async {
    final row = await (_db.select(_db.dbAppPrefs)
          ..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    return row?.launchAtLogin ?? false;
  }

  @override
  Future<void> setLaunchAtLogin(bool value) async {
    await _db.into(_db.dbAppPrefs).insertOnConflictUpdate(
          DbAppPrefsCompanion.insert(
            id: const Value(1),
            launchAtLogin: Value(value),
          ),
        );
  }
}
