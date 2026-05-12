import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/command_collection.dart';
import '../dto/run_snapshot.dart';
import '../ports/command_executor.dart';

/// Keeps each command line in a collection alive: on exit, waits 1s and respawns.
class CollectionSupervisor {
  CollectionSupervisor({
    required CommandExecutor executor,
    required ValueNotifier<RunSnapshot> runState,
  })  : _executor = executor,
        _runState = runState;

  final CommandExecutor _executor;
  final ValueNotifier<RunSnapshot> _runState;

  final Map<String, bool> _shouldRun = {};
  final Map<String, List<ManagedProcess?>> _processes = {};
  final Map<String, List<SlotSnapshot>> _slotSnapshots = {};

  bool isActive(String collectionId) => _shouldRun[collectionId] == true;

  Future<void> start(CommandCollection collection) async {
    final id = collection.id;
    if (_shouldRun[id] == true) return;
    if (collection.commands.isEmpty) return;

    _shouldRun[id] = true;
    final n = collection.commands.length;
    _processes[id] = List<ManagedProcess?>.filled(n, null, growable: false);
    _slotSnapshots[id] = List.generate(
      n,
      (_) => const SlotSnapshot(phase: SlotPhase.idle),
      growable: false,
    );
    _emit();

    for (var i = 0; i < n; i++) {
      unawaited(_superviseSlot(id, i, collection.commands[i]));
    }
  }

  Future<void> stop(String collectionId) async {
    _shouldRun[collectionId] = false;
    final procs = _processes[collectionId];
    if (procs != null) {
      for (final p in procs) {
        p?.terminate();
      }
    }
    _processes.remove(collectionId);
    _slotSnapshots.remove(collectionId);
    _shouldRun.remove(collectionId);
    _emit();
  }

  Future<void> stopAll() async {
    for (final id in _shouldRun.keys.toList()) {
      await stop(id);
    }
  }

  Future<void> _superviseSlot(
    String collectionId,
    int index,
    String commandLine,
  ) async {
    while (_shouldRun[collectionId] == true) {
      _setSlot(collectionId, index, const SlotSnapshot(phase: SlotPhase.running));
      _emit();

      ManagedProcess? proc;
      int code = 0;
      try {
        proc = await _executor.spawn(commandLine);
        _processes[collectionId]?[index] = proc;
        code = await proc.exitCode;
      } catch (_) {
        code = -1;
      } finally {
        _processes[collectionId]?[index] = null;
      }

      if (_shouldRun[collectionId] != true) break;

      _setSlot(
        collectionId,
        index,
        SlotSnapshot(phase: SlotPhase.cooldown, lastExitCode: code),
      );
      _emit();
      await Future<void>.delayed(const Duration(seconds: 1));
    }

    _setSlot(collectionId, index, const SlotSnapshot(phase: SlotPhase.idle));
    _emit();
  }

  void _setSlot(String collectionId, int index, SlotSnapshot snap) {
    final list = _slotSnapshots[collectionId];
    if (list == null || index >= list.length) return;
    list[index] = snap;
  }

  void _emit() {
    final map = <String, CollectionRunSnapshot>{};
    for (final entry in _slotSnapshots.entries) {
      final id = entry.key;
      final slots = List<SlotSnapshot>.from(entry.value);
      map[id] = CollectionRunSnapshot(
        active: _shouldRun[id] == true,
        slots: slots,
      );
    }
    _runState.value = RunSnapshot(map);
  }
}
