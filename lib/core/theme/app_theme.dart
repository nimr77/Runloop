import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const double screenPaddingH = 24;
  static const double screenPaddingV = 16;
  static const double sectionGap = 20;
  static const double cardInnerPadding = 20;
  static const double appBarToolbarHeight = 52;

  /// Soft page backdrop so elevated cards read clearly.
  static BoxDecoration meshBackground(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(scheme.surface, scheme.primaryContainer, 0.12)!,
          scheme.surface,
        ],
      ),
    );
  }

  static ThemeData light() {
    const seed = Color(0xFF1B6B5C);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
      surface: const Color(0xFFE8F0EE),
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    final noHoverOverlay = WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.onSurface.withValues(alpha: 0.08);
        }
        return Colors.transparent;
      },
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: '.AppleSystemUIFont',
      scaffoldBackgroundColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: buttonShape,
        ).copyWith(
          overlayColor: noHoverOverlay,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: buttonShape,
        ).copyWith(
          overlayColor: noHoverOverlay,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ).copyWith(
          overlayColor: noHoverOverlay,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ).copyWith(
          overlayColor: noHoverOverlay,
        ),
      ),
      switchTheme: const SwitchThemeData(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        titleSpacing: AppTheme.screenPaddingH - 8,
        toolbarHeight: AppTheme.appBarToolbarHeight,
      ),
    );
  }
}
