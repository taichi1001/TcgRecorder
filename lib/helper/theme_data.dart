import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/theme_provider.dart';

final lightThemeDataProvider = Provider.family<ThemeData, BuildContext>(
  ((ref, context) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    return FlexThemeData.light(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        textButtonSchemeColor: SchemeColor.secondary,
        elevatedButtonSchemeColor: SchemeColor.onSecondary,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
      ),
      keyColors: const FlexKeyColors(
        useTertiary: true,
      ),
      tones: FlexTones.jolly(Brightness.light),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
    );
  }),
);

final darkThemeDataProvider = Provider.family<ThemeData, BuildContext>(
  ((ref, context) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    return FlexThemeData.dark(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
      blendLevel: 15,
      appBarOpacity: 0.95,
      subThemesData: const FlexSubThemesData(
        textButtonSchemeColor: SchemeColor.secondary,
        elevatedButtonSchemeColor: SchemeColor.onSecondary,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
      ),
      keyColors: const FlexKeyColors(
        useTertiary: true,
        keepPrimary: true,
      ),
      tones: FlexTones.jolly(Brightness.dark).onMainsUseBW().onSurfacesUseBW(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            titleTextStyle: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(),
      ),
    );
  }),
);

final previewLightThemeDataProvider = Provider<ThemeData>(
  ((ref) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.previewScheme));
    return FlexThemeData.light(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        textButtonSchemeColor: SchemeColor.secondary,
        elevatedButtonSchemeColor: SchemeColor.onSecondary,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
      ),
      keyColors: const FlexKeyColors(
        useTertiary: true,
      ),
      tones: FlexTones.jolly(Brightness.light),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }),
);

final previewDarkThemeDataProvider = Provider<ThemeData>(
  ((ref) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.previewScheme));
    return FlexThemeData.dark(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
      blendLevel: 15,
      appBarOpacity: 0.95,
      subThemesData: const FlexSubThemesData(
        textButtonSchemeColor: SchemeColor.secondary,
        elevatedButtonSchemeColor: SchemeColor.onSecondary,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
      ),
      keyColors: const FlexKeyColors(
        useTertiary: true,
        keepPrimary: true,
      ),
      tones: FlexTones.jolly(Brightness.dark).onMainsUseBW().onSurfacesUseBW(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }),
);

final previewThemeDataListProvider = Provider.family.autoDispose<List<ThemeData>, bool>((ref, isDark) {
  final List<ThemeData> result = [];
  for (final scheme in FlexScheme.values) {
    if (scheme == FlexScheme.custom) break;
    if (isDark) {
      result.add(
        FlexThemeData.dark(
          scheme: scheme,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
          blendLevel: 15,
          appBarOpacity: 0.95,
          subThemesData: const FlexSubThemesData(
            textButtonSchemeColor: SchemeColor.secondary,
            elevatedButtonSchemeColor: SchemeColor.onSecondary,
            elevatedButtonSecondarySchemeColor: SchemeColor.primary,
            inputDecoratorIsFilled: false,
            inputDecoratorBorderType: FlexInputBorderType.underline,
            bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
            bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
          ),
          keyColors: const FlexKeyColors(
            useTertiary: true,
            keepPrimary: true,
          ),
          tones: FlexTones.jolly(Brightness.dark).onMainsUseBW().onSurfacesUseBW(),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
      );
    } else {
      result.add(
        FlexThemeData.light(
          scheme: scheme,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
          blendLevel: 9,
          subThemesData: const FlexSubThemesData(
            textButtonSchemeColor: SchemeColor.secondary,
            elevatedButtonSchemeColor: SchemeColor.onSecondary,
            elevatedButtonSecondarySchemeColor: SchemeColor.primary,
            inputDecoratorIsFilled: false,
            inputDecoratorBorderType: FlexInputBorderType.underline,
            bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
            bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
          ),
          keyColors: const FlexKeyColors(
            useTertiary: true,
          ),
          tones: FlexTones.jolly(Brightness.light),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
      );
    }
  }
  return result;
});
