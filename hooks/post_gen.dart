import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  context.logger.info('Running post-generation tasks...');

  try {
    // ! Run `flutter pub get`
    context.logger.info('Fetching dependencies...');
    final pubGetResult = await Process.run('flutter', ['pub', 'get']);
    stdout.write(pubGetResult.stdout);
    stderr.write(pubGetResult.stderr);

    // ! Run `flutter pub run flutter_flavorizr`
    context.logger.info('Generating flavors...');

    final flavorizrResult = await Process.run('flutter', ['pub', 'run', 'flutter_flavorizr']);
    stdout.write(flavorizrResult.stdout);
    stderr.write(flavorizrResult.stderr);

    if (flavorizrResult.exitCode == 0) {
      context.logger.info('Flutter project with flavors setup complete!');
    }

    // ! Run `flutter gen-l10n`
    context.logger.info('Generating l10n app_localizations.dart...');

    final l10nResult = await Process.run('flutter', ['gen-l10n']);
    stdout.write(l10nResult.stdout);
    stderr.write(l10nResult.stderr);

    if (l10nResult.exitCode == 0) {
      context.logger.info('l10n app_localizations setup complete!');
    }
  } catch (e) {
    context.logger.err('Error during post-generation: $e');
  }
}