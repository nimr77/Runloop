import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'application/supervisor/collection_supervisor.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'domain/repositories/app_preferences_repository.dart';
import 'domain/repositories/command_collection_repository.dart';
import 'infrastructure/database/app_database.dart';
import 'infrastructure/startup/launch_at_login_sync.dart';
import 'presentation/services/tray_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS) {
    final info = await PackageInfo.fromPlatform();
    launchAtStartup.setup(
      appName: info.appName,
      appPath: Platform.resolvedExecutable,
      packageName: info.packageName,
    );
  }

  await configureDependencies();

  if (Platform.isMacOS) {
    await windowManager.ensureInitialized();
  }

  runApp(const RunloopApp());
}

class RunloopApp extends StatefulWidget {
  const RunloopApp({super.key});

  @override
  State<RunloopApp> createState() => _RunloopAppState();
}

class _RunloopAppState extends State<RunloopApp> with WindowListener {
  late final GoRouter _router;
  TrayController? _tray;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter();
    if (Platform.isMacOS) {
      _tray = TrayController(
        runState: sl(),
        collections: sl(),
        onQuit: _quitApplication,
        onStopAll: () async {
          await sl<CollectionSupervisor>().stopAll();
        },
      );
      windowManager.addListener(this);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!Platform.isMacOS) return;
      await reconcileLaunchAtLoginState(
        prefs: sl<AppPreferencesRepository>(),
        collections: sl<CommandCollectionRepository>(),
      );
      await windowManager.setTitle('Runloop');
      await windowManager.setMinimumSize(const Size(520, 440));
      await windowManager.setPreventClose(true);
      await windowManager.show();
      await _tray?.init();
    });
  }

  Future<void> _quitApplication() async {
    await sl<CollectionSupervisor>().stopAll();
    _tray?.dispose();
    _tray = null;
    if (sl.isRegistered<AppDatabase>()) {
      await sl<AppDatabase>().close();
    }
    if (Platform.isMacOS) {
      await trayManager.destroy();
      await windowManager.destroy();
    }
    exit(0);
  }

  @override
  void onWindowClose() async {
    if (Platform.isMacOS) {
      await windowManager.hide();
    }
  }

  @override
  void dispose() {
    if (Platform.isMacOS) {
      windowManager.removeListener(this);
    }
    _tray?.dispose();
    _tray = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Runloop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: _router,
    );
  }
}
