import '../../application/supervisor/collection_supervisor.dart';
import '../../core/di/service_locator.dart';
import '../../presentation/notifiers/collections_notifier.dart';

Future<void> startCollectionsMarkedAutoRun() async {
  final list = sl<CollectionsNotifier>().value;
  final sup = sl<CollectionSupervisor>();
  for (final c in list) {
    if (c.autoRunOnAppStart && c.commands.isNotEmpty) {
      await sup.start(c);
    }
  }
}
