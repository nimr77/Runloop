import 'package:flutter/material.dart';

/// Subtle scale on pointer hover (desktop). No shadow changes.
class HoverScale extends StatefulWidget {
  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.018,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
    this.enabled = true,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;
  final bool enabled;
  final Alignment alignment;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    final t = _hover ? widget.scale : 1.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: t,
        duration: widget.duration,
        curve: widget.curve,
        alignment: widget.alignment,
        child: widget.child,
      ),
    );
  }
}
