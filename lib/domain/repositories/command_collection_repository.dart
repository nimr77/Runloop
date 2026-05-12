import '../entities/command_collection.dart';

abstract interface class CommandCollectionRepository {
  Future<List<CommandCollection>> loadAll();
  Future<void> save(CommandCollection collection);
  Future<void> delete(String id);
}
