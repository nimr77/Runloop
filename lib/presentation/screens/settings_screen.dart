import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

import '../../core/di/service_locator.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../notifiers/collections_notifier.dart';
import '../widgets/shadow_card.dart';
import '../widgets/hover_scale.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _launchAtLogin = false;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    sl<CollectionsNotifier>().addListener(_onCollectionsChanged);
    _load();
  }

  @override
  void dispose() {
    sl<CollectionsNotifier>().removeListener(_onCollectionsChanged);
    super.dispose();
  }

  void _onCollectionsChanged() {
    if (mounted) setState(() {});
  }

  bool get _anyAutoRunCollection {
    return sl<CollectionsNotifier>().value.any(
          (c) => c.autoRunOnAppStart && c.commands.isNotEmpty,
        );
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final prefs = sl<AppPreferencesRepository>();
      final stored = await prefs.getLaunchAtLogin();
      var effective = stored;
      if (Platform.isMacOS) {
        try {
          effective = await launchAtStartup.isEnabled();
        } catch (_) {
          effective = stored;
        }
      }
      setState(() {
        _launchAtLogin = effective;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _setLaunchAtLogin(bool value) async {
    if (_anyAutoRunCollection && !value) return;
    setState(() => _launchAtLogin = value);
    try {
      await sl<AppPreferencesRepository>().setLaunchAtLogin(value);
      if (Platform.isMacOS) {
        if (value) {
          await launchAtStartup.enable();
        } else {
          await launchAtStartup.disable();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update login item: $e')),
        );
      }
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final forcedByAutoRun = _anyAutoRunCollection;
    final switchOn = forcedByAutoRun || _launchAtLogin;

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
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.screenPaddingH,
            AppTheme.screenPaddingV,
            AppTheme.screenPaddingH,
            AppTheme.screenPaddingV,
          ),
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ShadowCard(
              borderRadius: BorderRadius.circular(18),
              child: _loading
                  ? const Padding(
                      padding: EdgeInsets.all(28),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Column(
                      children: [
                        SwitchListTile.adaptive(
                          title: const Text('Open at login'),
                          subtitle: Text(
                            forcedByAutoRun
                                ? 'On automatically while a collection uses “Auto-run when app starts”.'
                                : Platform.isMacOS
                                    ? 'Adds Runloop to your user login items (macOS).'
                                    : 'Supported on macOS when the app is built with the login helper.',
                          ),
                          value: switchOn,
                          onChanged: Platform.isMacOS && !forcedByAutoRun
                              ? _setLaunchAtLogin
                              : null,
                        ),
                        if (!Platform.isMacOS)
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(
                              'Launch at login is only configured for macOS in this build.',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                      ],
                    ),
            ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.04, end: 0),
            const SizedBox(height: 18),
            Text(
              'Data is stored in SQLite under Application Support → runloop.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
