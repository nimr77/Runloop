import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../application/dto/run_snapshot.dart';
import '../../application/ports/command_executor.dart';
import '../../application/supervisor/collection_supervisor.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../../domain/repositories/command_collection_repository.dart';
import '../../infrastructure/database/app_database.dart';
import '../../infrastructure/persistence/drift_app_preferences_repository.dart';
import '../../infrastructure/persistence/drift_command_collection_repository.dart';
import '../../infrastructure/persistence/legacy_json_importer.dart';
import '../../infrastructure/process/io_command_executor.dart';
import '../../infrastructure/startup/auto_run_bootstrap.dart';
import '../../presentation/notifiers/collections_notifier.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  final db = AppDatabase();
  sl.registerSingleton<AppDatabase>(db);
  await LegacyJsonImporter.maybeImport(db);

  sl.registerLazySingleton<CommandCollectionRepository>(
    () => DriftCommandCollectionRepository(sl()),
  );
  sl.registerLazySingleton<AppPreferencesRepository>(
    () => DriftAppPreferencesRepository(sl()),
  );
  sl.registerLazySingleton<CommandExecutor>(IoCommandExecutor.new);
  sl.registerLazySingleton<ValueNotifier<RunSnapshot>>(
    () => ValueNotifier(RunSnapshot.empty),
  );
  sl.registerLazySingleton(
    () => CollectionSupervisor(
      executor: sl<CommandExecutor>(),
      runState: sl<ValueNotifier<RunSnapshot>>(),
    ),
  );
  sl.registerLazySingleton(
    () => CollectionsNotifier(
      sl<CommandCollectionRepository>(),
      sl<AppPreferencesRepository>(),
    ),
  );
  await sl<CollectionsNotifier>().load();
  await startCollectionsMarkedAutoRun();
}
