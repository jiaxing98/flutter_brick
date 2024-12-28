part of 'theme_cubit.dart';

@immutable
final class ThemeState extends Equatable {
  final ThemeMode mode;
  final ({ThemeData light, ThemeData dark}) theme;

  const ThemeState({
    required this.mode,
    required this.theme,
  });

  ThemeState copyWith({
    ThemeMode? mode,
    ({ThemeData light, ThemeData dark})? theme,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      theme: theme ?? this.theme,
    );
  }

  ThemeData get light => theme.light;
  ThemeData get dark => theme.dark;

  @override
  List<Object> get props => [mode, theme];
}
