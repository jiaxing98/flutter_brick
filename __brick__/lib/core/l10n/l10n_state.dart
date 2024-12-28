part of 'l10n_cubit.dart';

@immutable
final class L10nState extends Equatable {
  final Locale locale;
  final List<Locale> supportedLocales;

  const L10nState({
    required this.locale,
    required this.supportedLocales,
  });

  L10nState copyWith({
    Locale? locale,
  }) {
    return L10nState(
      locale: locale ?? this.locale,
      supportedLocales: supportedLocales,
    );
  }

  @override
  List<Object> get props => [locale, supportedLocales];
}
