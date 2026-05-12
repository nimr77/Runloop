import 'package:flutter/material.dart';

/// Solid surface card with a small shadow; shadow strengthens on pointer hover.
class ShadowCard extends StatefulWidget {
  const ShadowCard({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  State<ShadowCard> createState() => _ShadowCardState();
}

class _ShadowCardState extends State<ShadowCard> {
  bool _hover = false;

  List<BoxShadow> _shadowsFor(bool hover) {
    if (hover) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.14),
          blurRadius: 22,
          offset: const Offset(0, 6),
        ),
      ];
    }
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.055),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: widget.borderRadius,
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: _hover ? 0.42 : 0.28),
          ),
          boxShadow: _shadowsFor(_hover),
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.padding != null
              ? Padding(padding: widget.padding!, child: widget.child)
              : widget.child,
        ),
      ),
    );
  }
}
