import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{project_name}}/core/l10n/l10n.dart';
import 'package:{{project_name}}/core/theme/theme.dart';
import 'package:{{project_name}}/env.dart';

GetIt sl = GetIt.instance;

Future<void> initializedApp() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  final defaultTheme =
      appThemes[Env.defaultThemeData] ?? (light: RoseWoodX.light(), dark: RoseWoodX.dark());
  final theme = sl
      .registerSingleton<ThemeCubit>(ThemeCubit(sp: sharedPreferences, defaultTheme: defaultTheme));
  theme.loadTheme();

  sl.registerSingleton<L10nCubit>(
    L10nCubit(
      defaultLocale: Locale('en'),
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('ja'),
      ],
    ),
  );

  _injectRepositories();
  _injectBlocs();
}

void _injectRepositories() {}

void _injectBlocs() {
  // ! singleton - use BlocProvider.value to not close the stream

  // ! factory - use BlocProvider to create new instance
}
