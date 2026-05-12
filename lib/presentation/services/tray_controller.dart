import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../../application/dto/run_snapshot.dart';
import '../../domain/entities/command_collection.dart';
import '../notifiers/collections_notifier.dart';

/// Syncs menu-bar tray tooltip and menu from app state.
class TrayController with TrayListener {
  TrayController({
    required ValueNotifier<RunSnapshot> runState,
    required CollectionsNotifier collections,
    required Future<void> Function() onQuit,
    required Future<void> Function() onStopAll,
  })  : _runState = runState,
        _collections = collections,
        _onQuit = onQuit,
        _onStopAll = onStopAll {
    _runState.addListener(_onChanged);
    _collections.addListener(_onChanged);
    trayManager.addListener(this);
  }

  final ValueNotifier<RunSnapshot> _runState;
  final CollectionsNotifier _collections;
  final Future<void> Function() _onQuit;
  final Future<void> Function() _onStopAll;
  bool _ready = false;
  bool _disposed = false;

  Future<void> init() async {
    if (!Platform.isMacOS) return;
    await trayManager.setIcon(
      'assets/icons/tray.png',
      isTemplate: false,
    );
    _ready = true;
    await _sync();
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _runState.removeListener(_onChanged);
    _collections.removeListener(_onChanged);
    trayManager.removeListener(this);
  }

  void _onChanged() {
    if (_ready) {
      unawaited(_sync());
    }
  }

  Future<void> _sync() async {
    if (!Platform.isMacOS || !_ready) return;

    final run = _runState.value;
    final cols = _collections.value;
    final active = run.activeCollections;
    final slots = run.totalRunningSlots;

    final tip = active == 0
        ? 'Runloop — idle'
        : 'Runloop — $active collection${active == 1 ? '' : 's'}, $slots process${slots == 1 ? '' : 'es'}';

    await trayManager.setToolTip(tip);
    await trayManager.setTitle(active > 0 ? '●' : '○');

    final items = <MenuItem>[
      MenuItem(
        key: 'open',
        label: 'Open Runloop',
        onClick: (_) async {
          await windowManager.show();
          await windowManager.focus();
        },
      ),
      MenuItem(
        key: 'stop_all',
        label: 'Stop all processes',
        onClick: (_) => _onStopAll(),
      ),
      MenuItem.separator(),
      ...cols.map(
        (c) => MenuItem(
          key: 'c_${c.id}',
          label: _menuLabel(c, run),
          toolTip: c.commands.isEmpty ? 'No commands' : c.commands.first,
        ),
      ),
      if (cols.isNotEmpty) MenuItem.separator(),
      MenuItem(
        key: 'quit',
        label: 'Quit Runloop',
        onClick: (_) => _onQuit(),
      ),
    ];

    await trayManager.setContextMenu(Menu(items: items));
  }

  String _menuLabel(CommandCollection c, RunSnapshot run) {
    final snap = run.byCollectionId[c.id];
    final on = snap?.active == true;
    final n = snap?.runningCount ?? 0;
    final total = c.commands.length;
    if (on) {
      return '${c.name}  ($n/$total live)';
    }
    return c.name;
  }

  @override
  void onTrayIconMouseUp() {
    windowManager.show();
    windowManager.focus();
  }
}
