/// Outbound port: run one shell line (login shell for PATH, keys, ssh config).
abstract interface class CommandExecutor {
  Future<ManagedProcess> spawn(String commandLine);
}

abstract class ManagedProcess {
  Future<int> get exitCode;
  void terminate();
}
