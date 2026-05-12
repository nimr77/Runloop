import 'dart:io';

import 'package:launch_at_startup/launch_at_startup.dart';

import '../../domain/repositories/app_preferences_repository.dart';
import '../../domain/repositories/command_collection_repository.dart';

/// Keeps the login item aligned with SQLite and with collections that use
/// auto-run on app start (the app must launch at login for those to run).
Future<void> reconcileLaunchAtLoginState({
  required AppPreferencesRepository prefs,
  required CommandCollectionRepository collections,
}) async {
  if (!Platform.isMacOS) return;
  try {
    final list = await collections.loadAll();
    final anyAutoRun = list.any(
      (c) => c.autoRunOnAppStart && c.commands.isNotEmpty,
    );

    if (anyAutoRun) {
      await prefs.setLaunchAtLogin(true);
      if (!await launchAtStartup.isEnabled()) {
        await launchAtStartup.enable();
      }
      return;
    }

    final want = await prefs.getLaunchAtLogin();
    final enabled = await launchAtStartup.isEnabled();
    if (want && !enabled) {
      await launchAtStartup.enable();
    } else if (!want && enabled) {
      await launchAtStartup.disable();
    }
  } catch (_) {}
}
