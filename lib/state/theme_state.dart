import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  factory ThemeState({
    @Default(FlexScheme.ebonyClay) final FlexScheme scheme,
  }) = _ThemeState;
}
