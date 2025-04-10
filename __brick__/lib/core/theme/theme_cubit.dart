import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{project_name}}/core/theme/theme.dart';

part 'theme_state.dart';

const _themeMode = "THEME_MODE";
const _themeData = "THEME_DATA";

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _sp;

  ThemeCubit({
    required SharedPreferences sp,
    required ({ThemeData light, ThemeData dark}) defaultTheme,
  })  : _sp = sp,
        super(
        ThemeState(
          mode: ThemeMode.system,
          theme: defaultTheme,
        ),
      );

  void loadTheme(Brightness brightness) {
    final index = _sp.getInt(_themeMode);
    final key = _sp.getString(_themeData);

    ThemeMode savedMode = index != null ? ThemeMode.values[index] : state.mode;
    if (savedMode == ThemeMode.system) {
      savedMode = brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
    }

    ({ThemeData light, ThemeData dark})? savedTheme =
        (key != null && appThemes.containsKey(key)) ? appThemes[key]! : state.theme;

    emit(state.copyWith(mode: savedMode, theme: savedTheme));
  }

  Future<void> changeMode(ThemeMode mode) async {
    await _sp.setInt(_themeMode, mode.index);
    emit(state.copyWith(mode: mode));
  }

  Future<void> changeTheme() async {
    var random = Random().nextInt(appThemes.length);
    final randomTheme = appThemes.entries.toList()[random];

    await _sp.setString(_themeData, randomTheme.key);
    emit(state.copyWith(theme: randomTheme.value));
  }
}
