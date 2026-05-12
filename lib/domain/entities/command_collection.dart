/// Aggregate root: a named set of shell lines executed together.
class CommandCollection {
  const CommandCollection({
    required this.id,
    required this.name,
    required this.commands,
    this.autoRunOnAppStart = false,
  });

  final String id;
  final String name;
  final List<String> commands;
  final bool autoRunOnAppStart;

  CommandCollection copyWith({
    String? id,
    String? name,
    List<String>? commands,
    bool? autoRunOnAppStart,
  }) {
    return CommandCollection(
      id: id ?? this.id,
      name: name ?? this.name,
      commands: commands ?? this.commands,
      autoRunOnAppStart: autoRunOnAppStart ?? this.autoRunOnAppStart,
    );
  }
}
