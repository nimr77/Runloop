import 'package:flutter/foundation.dart';

enum SlotPhase { idle, running, cooldown }

@immutable
class SlotSnapshot {
  const SlotSnapshot({required this.phase, this.lastExitCode});

  final SlotPhase phase;
  final int? lastExitCode;
}

@immutable
class CollectionRunSnapshot {
  const CollectionRunSnapshot({
    required this.active,
    required this.slots,
  });

  final bool active;
  final List<SlotSnapshot> slots;

  int get runningCount =>
      slots.where((s) => s.phase == SlotPhase.running).length;
}

@immutable
class RunSnapshot {
  const RunSnapshot(this.byCollectionId);

  final Map<String, CollectionRunSnapshot> byCollectionId;

  static const empty = RunSnapshot({});

  int get activeCollections =>
      byCollectionId.values.where((c) => c.active).length;

  int get totalRunningSlots => byCollectionId.values.fold(
        0,
        (a, c) => a + c.runningCount,
      );
}
