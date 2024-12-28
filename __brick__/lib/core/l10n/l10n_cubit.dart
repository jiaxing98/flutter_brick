import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'l10n_state.dart';

class L10nCubit extends Cubit<L10nState> {
  L10nCubit({
    required Locale defaultLocale,
    required List<Locale> supportedLocales,
  }) : super(
          L10nState(locale: defaultLocale, supportedLocales: supportedLocales),
        );

  void changeLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
