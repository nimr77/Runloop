import 'package:flutter/foundation.dart';

import '../../domain/entities/command_collection.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../../domain/repositories/command_collection_repository.dart';
import '../../infrastructure/startup/launch_at_login_sync.dart';

class CollectionsNotifier extends ValueNotifier<List<CommandCollection>> {
  CollectionsNotifier(this._repo, this._prefs) : super(const []);

  final CommandCollectionRepository _repo;
  final AppPreferencesRepository _prefs;

  Future<void> load() async {
    value = await _repo.loadAll();
  }

  Future<void> upsert(CommandCollection collection) async {
    await _repo.save(collection);
    await load();
    await reconcileLaunchAtLoginState(prefs: _prefs, collections: _repo);
  }

  Future<void> remove(String id) async {
    await _repo.delete(id);
    await load();
    await reconcileLaunchAtLoginState(prefs: _prefs, collections: _repo);
  }
}
