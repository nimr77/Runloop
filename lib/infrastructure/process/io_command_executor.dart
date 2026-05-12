import 'dart:io';

import '../../application/ports/command_executor.dart';

class IoManagedProcess implements ManagedProcess {
  IoManagedProcess(this._process);

  final Process _process;

  @override
  Future<int> get exitCode => _process.exitCode;

  @override
  void terminate() {
    try {
      _process.kill(ProcessSignal.sigterm);
    } catch (_) {}
  }
}

class IoCommandExecutor implements CommandExecutor {
  @override
  Future<ManagedProcess> spawn(String commandLine) async {
    final process = await Process.start(
      '/bin/zsh',
      ['-l', '-c', commandLine],
      environment: Platform.environment,
      includeParentEnvironment: true,
    );
    // Avoid stdout/stderr backpressure freezing ssh.
    process.stdout.listen((_) {}, onError: (_) {});
    process.stderr.listen((_) {}, onError: (_) {});
    return IoManagedProcess(process);
  }
}
