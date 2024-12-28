import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:{{project_name}}/core/l10n/l10n.dart';
import 'package:{{project_name}}/core/service_locator.dart';
import 'package:{{project_name}}/core/theme/theme.dart';
import 'package:{{project_name}}/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => sl.get<ThemeCubit>(),
        ),
        BlocProvider(
          create: (ctx) => sl.get<L10nCubit>(),
        )
      ],
      child: Builder(
        builder: (context) {
          final l10n = context.watch<L10nCubit>().state;
          final theme = context.watch<ThemeCubit>().state;

          return GlobalLoaderOverlay(
            overlayWidgetBuilder: (_) {
              return const Center(
                child: SpinKitWanderingCubes(
                  color: Colors.white,
                  size: 50.0,
                ),
              );
            },
            child: MaterialApp.router(
              routerConfig: router,
              themeMode: theme.mode,
              theme: theme.light,
              darkTheme: theme.dark,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: l10n.locale,
              supportedLocales: l10n.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
