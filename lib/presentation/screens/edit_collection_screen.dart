import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../application/supervisor/collection_supervisor.dart';
import '../../core/di/service_locator.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/command_collection.dart';
import '../notifiers/collections_notifier.dart';
import '../widgets/shadow_card.dart';
import '../widgets/hover_scale.dart';

class EditCollectionScreen extends StatefulWidget {
  const EditCollectionScreen({super.key, this.collectionId});

  final String? collectionId;

  @override
  State<EditCollectionScreen> createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  late final TextEditingController _name;
  late final TextEditingController _commands;
  late bool _autoRunOnAppStart;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final existing = _existing;
    _name = TextEditingController(text: existing?.name ?? '');
    _commands = TextEditingController(
      text: existing?.commands.join('\n') ?? '',
    );
    _autoRunOnAppStart = existing?.autoRunOnAppStart ?? false;
  }

  CommandCollection? get _existing {
    final id = widget.collectionId;
    if (id == null) return null;
    try {
      return sl<CollectionsNotifier>().value.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _commands.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final lines = _commands.text
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    if (lines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one command line.')),
      );
      return;
    }

    final id = widget.collectionId ?? const Uuid().v4();
    final collection = CommandCollection(
      id: id,
      name: _name.text.trim(),
      commands: lines,
      autoRunOnAppStart: _autoRunOnAppStart,
    );

    await sl<CollectionsNotifier>().upsert(collection);
    if (mounted) context.go('/');
  }

  Future<void> _delete() async {
    final id = widget.collectionId;
    if (id == null) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete collection?'),
        content: const Text('Stopped processes will not restart.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await sl<CollectionSupervisor>().stop(id);
    await sl<CollectionsNotifier>().remove(id);
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.collectionId == null;
    final missing = widget.collectionId != null && _existing == null;

    if (missing) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text(
            'Collection not found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: AppTheme.appBarToolbarHeight,
        leading: HoverScale(
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            onPressed: () => context.go('/'),
          ),
        ),
        title: Text(isNew ? 'New collection' : 'Edit collection'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.screenPaddingH,
              AppTheme.screenPaddingV,
              AppTheme.screenPaddingH,
              AppTheme.screenPaddingV + 8,
            ),
            children: [
              ShadowCard(
                borderRadius: BorderRadius.circular(18),
                padding: const EdgeInsets.all(AppTheme.cardInnerPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'e.g. Keycloak prod tunnel',
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Auto-run when app starts'),
                      subtitle: const Text(
                        'Starts after Runloop launches. Open at login is turned on automatically when this is enabled.',
                      ),
                      value: _autoRunOnAppStart,
                      onChanged: (v) =>
                          setState(() => _autoRunOnAppStart = v),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 350.ms),
              SizedBox(height: AppTheme.sectionGap - 4),
              Text(
                'Commands',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'One process per line. Uses login zsh (-l) so your PATH and SSH config apply.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 12),
              ShadowCard(
                borderRadius: BorderRadius.circular(18),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardInnerPadding - 4,
                  vertical: 14,
                ),
                child: TextFormField(
                  controller: _commands,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    hintText:
                        'ssh -N -L 5432:db.example.com:5432 user@bastion.example.com',
                  ),
                  style: const TextStyle(
                    fontFamily: 'Menlo',
                    fontSize: 13,
                    height: 1.45,
                  ),
                  maxLines: 12,
                  minLines: 6,
                  validator: (_) => null,
                ),
              ).animate().fadeIn(delay: 80.ms, duration: 400.ms),
              SizedBox(height: AppTheme.sectionGap + 4),
              Row(
                children: [
                  HoverScale(
                    child: FilledButton(
                      onPressed: _save,
                      child: Text(isNew ? 'Create' : 'Save'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  HoverScale(
                    child: OutlinedButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const Spacer(),
                  if (!isNew)
                    HoverScale(
                      child: TextButton(
                        onPressed: _delete,
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                ],
              ).animate().fadeIn(delay: 120.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
