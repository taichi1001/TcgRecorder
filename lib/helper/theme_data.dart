import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/theme_provider.dart';

final lightThemeDataProvider = Provider<ThemeData>(
  ((ref) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    return FlexThemeData.light(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 9,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.95,
      appBarElevation: 0.5,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      tooltipsMatchBackground: true,
      swapColors: false,
      lightIsWhite: false,
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      tones: FlexTones.material(Brightness.light),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // fontFamily: GoogleFonts.mPlus1p().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationBarMutedUnselectedLabel: true,
        navigationBarMutedUnselectedIcon: true,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedHasBorder: true,
        blendOnColors: true,
        blendTextTheme: true,
        popupMenuOpacity: 0.95,
      ),
    );
  }),
);

final darkThemeDataProvider = Provider<ThemeData>(
  ((ref) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    return FlexThemeData.dark(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 9,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.95,
      appBarElevation: 0.5,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      tooltipsMatchBackground: true,
      swapColors: false,
      tones: FlexTones.material(Brightness.dark),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // fontFamily: GoogleFonts.mPlus1p().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationBarMutedUnselectedLabel: true,
        navigationBarMutedUnselectedIcon: true,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedHasBorder: true,
        blendOnColors: true,
        blendTextTheme: true,
        popupMenuOpacity: 0.95,
      ),
    ).copyWith(
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
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 9,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.95,
      appBarElevation: 0.5,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      tooltipsMatchBackground: true,
      swapColors: false,
      lightIsWhite: false,
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      tones: FlexTones.material(Brightness.light),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // fontFamily: GoogleFonts.mPlus1p().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationBarMutedUnselectedLabel: true,
        navigationBarMutedUnselectedIcon: true,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedHasBorder: true,
        blendOnColors: true,
        blendTextTheme: true,
        popupMenuOpacity: 0.95,
      ),
    );
  }),
);

final previewDarkThemeDataProvider = Provider<ThemeData>(
  ((ref) {
    final scheme = ref.watch(themeNotifierProvider.select((value) => value.previewScheme));
    return FlexThemeData.dark(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 9,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.95,
      appBarElevation: 0.5,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      tooltipsMatchBackground: true,
      swapColors: false,
      tones: FlexTones.material(Brightness.dark),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // fontFamily: GoogleFonts.mPlus1p().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 0.95,
        navigationBarOpacity: 0.95,
        navigationBarMutedUnselectedLabel: true,
        navigationBarMutedUnselectedIcon: true,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedHasBorder: true,
        blendOnColors: true,
        blendTextTheme: true,
        popupMenuOpacity: 0.95,
      ),
    ).copyWith(
      cupertinoOverrideTheme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(),
      ),
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
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 9,
          appBarStyle: FlexAppBarStyle.primary,
          appBarOpacity: 0.95,
          appBarElevation: 0.5,
          transparentStatusBar: true,
          tabBarStyle: FlexTabBarStyle.forAppBar,
          tooltipsMatchBackground: true,
          swapColors: false,
          tones: FlexTones.material(Brightness.dark),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          // fontFamily: GoogleFonts.mPlus1p().fontFamily,
          subThemesData: const FlexSubThemesData(
            useTextTheme: true,
            fabUseShape: true,
            interactionEffects: true,
            bottomNavigationBarElevation: 0,
            bottomNavigationBarOpacity: 0.95,
            navigationBarOpacity: 0.95,
            navigationBarMutedUnselectedLabel: true,
            navigationBarMutedUnselectedIcon: true,
            inputDecoratorIsFilled: false,
            inputDecoratorBorderType: FlexInputBorderType.underline,
            inputDecoratorUnfocusedHasBorder: true,
            blendOnColors: true,
            blendTextTheme: true,
            popupMenuOpacity: 0.95,
          ),
        ).copyWith(
          cupertinoOverrideTheme: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(),
          ),
        ),
      );
    } else {
      result.add(
        FlexThemeData.light(
          scheme: scheme,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 9,
          appBarStyle: FlexAppBarStyle.primary,
          appBarOpacity: 0.95,
          appBarElevation: 0.5,
          transparentStatusBar: true,
          tabBarStyle: FlexTabBarStyle.forAppBar,
          tooltipsMatchBackground: true,
          swapColors: false,
          lightIsWhite: false,
          keyColors: const FlexKeyColors(
            useSecondary: true,
            useTertiary: true,
          ),
          tones: FlexTones.material(Brightness.light),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          // fontFamily: GoogleFonts.mPlus1p().fontFamily,
          subThemesData: const FlexSubThemesData(
            useTextTheme: true,
            fabUseShape: true,
            interactionEffects: true,
            bottomNavigationBarElevation: 0,
            bottomNavigationBarOpacity: 0.95,
            navigationBarOpacity: 0.95,
            navigationBarMutedUnselectedLabel: true,
            navigationBarMutedUnselectedIcon: true,
            inputDecoratorIsFilled: false,
            inputDecoratorBorderType: FlexInputBorderType.underline,
            inputDecoratorUnfocusedHasBorder: true,
            blendOnColors: true,
            blendTextTheme: true,
            popupMenuOpacity: 0.95,
          ),
        ),
      );
    }
  }
  return result;
});
