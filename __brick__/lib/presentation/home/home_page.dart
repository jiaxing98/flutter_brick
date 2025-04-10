import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name}}/core/extensions/build_context.dart';
import 'package:{{project_name}}/core/l10n/l10n.dart';
import 'package:{{project_name}}/core/theme/theme.dart';
import 'package:{{project_name}}/presentation/home/widgets/action_button.dart';
import 'package:{{project_name}}/presentation/home/widgets/expandable_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.read<ThemeCubit>().changeTheme(),
          icon: Icon(Icons.brush),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.l10n.appBarTitle),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => context.read<ThemeCubit>().changeMode(
                  switch (state.mode) {
                    ThemeMode.light => ThemeMode.dark,
                    ThemeMode.dark => ThemeMode.light,
                    ThemeMode.system => context.brightness == Brightness.light
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  },
                ),
                icon: switch (state.mode) {
                  ThemeMode.light => Icon(Icons.light_mode),
                  ThemeMode.dark => Icon(Icons.dark_mode),
                  ThemeMode.system => context.brightness == Brightness.light
                      ? Icon(Icons.light_mode)
                      : Icon(Icons.dark_mode)
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(context.l10n.counterMessage),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 24.0),
                    OutlinedButton(
                      onPressed: _incrementCounter,
                      child: Text(context.l10n.incrementButton),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<L10nCubit, L10nState>(
        builder: (context, state) {
          return ExpandableFab(
            distance: 110,
            children: state.supportedLocales
                .map(
                  (e) => ActionButton(
                    locale: e,
                    onPressed: context.read<L10nCubit>().changeLocale,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
