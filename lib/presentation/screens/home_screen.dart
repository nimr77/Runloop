import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../application/dto/run_snapshot.dart';
import '../../application/supervisor/collection_supervisor.dart';
import '../../core/di/service_locator.dart';
import '../../core/theme/app_theme.dart';
import '../notifiers/collections_notifier.dart';
import '../widgets/shadow_card.dart';
import '../widgets/hover_scale.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = sl<CollectionsNotifier>();
    final runState = sl<ValueNotifier<RunSnapshot>>();
    final supervisor = sl<CollectionSupervisor>();
    final merged = Listenable.merge([collections, runState]);
    final topInset = MediaQuery.paddingOf(context).top;

    Future<void> stopAll() async {
      await supervisor.stopAll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All collections stopped')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: AppTheme.appBarToolbarHeight,
        title: Text(
          'Runloop',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
        ),
        flexibleSpace: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        actions: [
          HoverScale(
            child: IconButton(
              tooltip: 'Stop all processes',
              icon: const Icon(Icons.stop_circle_outlined),
              onPressed: () => stopAll(),
            ),
          ),
          HoverScale(
            child: IconButton(
              tooltip: 'Settings',
              icon: const Icon(Icons.tune_rounded),
              onPressed: () => context.push('/settings'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.screenPaddingH - 4),
            child: HoverScale(
              child: FilledButton.tonalIcon(
                onPressed: () => context.go('/new'),
                icon: const Icon(Icons.add_rounded, size: 20),
                label: const Text('New'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppTheme.screenPaddingH,
            topInset + AppTheme.appBarToolbarHeight + AppTheme.screenPaddingV,
            AppTheme.screenPaddingH,
            AppTheme.screenPaddingV,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Command collections · SQLite · auto-restart',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.02, curve: Curves.easeOutCubic),
              SizedBox(height: AppTheme.sectionGap),
              Expanded(
                child: ListenableBuilder(
                  listenable: merged,
                  builder: (context, _) {
                    final list = collections.value;
                    if (list.isEmpty) {
                      return _EmptyState(onCreate: () => context.go('/new'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 8),
                      itemCount: list.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final c = list[index];
                        final snap = runState.value.byCollectionId[c.id];
                        final active = snap?.active == true;
                        return ShadowCard(
                          borderRadius: BorderRadius.circular(18),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.cardInnerPadding,
                            vertical: 16,
                          ),
                          child: _CollectionRow(
                            name: c.name,
                            commandCount: c.commands.length,
                            active: active,
                            runningSlots: snap?.runningCount ?? 0,
                            autoRun: c.autoRunOnAppStart,
                            onEdit: () => context.go('/edit/${c.id}'),
                            onToggle: () async {
                              if (active) {
                                await supervisor.stop(c.id);
                              } else {
                                await supervisor.start(c);
                              }
                            },
                          ),
                        )
                            .animate(key: ValueKey(c.id))
                            .fadeIn(
                              delay: (50 * index).ms,
                              duration: 380.ms,
                            )
                            .slideY(
                              begin: 0.05,
                              end: 0,
                              delay: (50 * index).ms,
                              duration: 380.ms,
                              curve: Curves.easeOutCubic,
                            );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: ShadowCard(
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.cardInnerPadding + 8,
          vertical: 32,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.terminal_rounded,
                size: 52,
                color: scheme.primary.withValues(alpha: 0.5),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.06, 1.06),
                    duration: 2.seconds,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(height: 18),
              Text(
                'No collections yet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Store tunnels in local SQLite, enable auto-run on login, '
                'and keep processes alive with a 1s respawn loop.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.45,
                    ),
              ),
              const SizedBox(height: 26),
              HoverScale(
                child: FilledButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Create collection'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CollectionRow extends StatelessWidget {
  const _CollectionRow({
    required this.name,
    required this.commandCount,
    required this.active,
    required this.runningSlots,
    required this.autoRun,
    required this.onEdit,
    required this.onToggle,
  });

  final String name;
  final int commandCount;
  final bool active;
  final int runningSlots;
  final bool autoRun;
  final VoidCallback onEdit;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onEdit,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            _PulseDot(active: active),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      if (autoRun) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: scheme.primary.withValues(alpha: 0.18),
                          ),
                          child: Text(
                            'AUTO',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    active
                        ? '$runningSlots / $commandCount processes live'
                        : '$commandCount shell line${commandCount == 1 ? '' : 's'} · stopped',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            HoverScale(
              scale: 1.04,
              alignment: Alignment.center,
              child: FilledButton.tonal(
                onPressed: onToggle,
                style: FilledButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  backgroundColor: active
                      ? scheme.errorContainer.withValues(alpha: 0.55)
                      : scheme.primaryContainer.withValues(alpha: 0.45),
                  foregroundColor: active
                      ? scheme.onErrorContainer
                      : scheme.onPrimaryContainer,
                ),
                child: Text(active ? 'Stop' : 'Run'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : scheme.outline;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: active ? 1 : 0.35),
        boxShadow: active
            ? [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.35),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
    );
  }
}
