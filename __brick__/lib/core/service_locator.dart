import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{project_name}}/core/l10n/l10n.dart';
import 'package:{{project_name}}/core/theme/theme.dart';
import 'package:{{project_name}}/core/token_storage.dart';
import 'package:{{project_name}}/env.dart';

GetIt sl = GetIt.instance;

Future<void> initializedApp() async {
  // * HydratedBloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  // * SharedPreference
  final sp = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sp);

  // * Theme
  final defaultTheme =
      appThemes[Env.defaultThemeData] ?? (light: RoseWoodX.light(), dark: RoseWoodX.dark());
  final theme = sl
      .registerSingleton<ThemeCubit>(ThemeCubit(sp: sp, defaultTheme: defaultTheme));
  theme.loadTheme();

  // * L10n
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

  // * TokenStorage
  final tokenStorage = sl.registerSingleton<TokenStorage>(TokenStorage(sp: sp));

  // * Dio
  final dio = sl.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: Env.baseUrl)));
  // ! This should be the last interceptor added,
  // ! otherwise modifications by following interceptors will not be logged.
  // * Dio
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ),
  );

  // * Dependencies
  _injectDataSources();
  _injectRepositories();
  _injectBlocs();
}

void _injectDataSources() {
  final dio = sl.get<Dio>();
}

void _injectRepositories() {}

void _injectBlocs() {
  // ! singleton - use BlocProvider.value to not close the stream

  // ! factory - use BlocProvider to create new instance
}
