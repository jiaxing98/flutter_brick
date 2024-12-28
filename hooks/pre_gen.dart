import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  // ! Read project name from pubspec.yaml
  final pubspec = File('pubspec.yaml');
  if (pubspec.existsSync()) {
    final lines = pubspec.readAsLinesSync();
    final projectNameLine = lines.firstWhere((line) => line.startsWith('name:'));
    final projectName = projectNameLine.split(':').last.trim();
    context.vars['project_name'] = projectName;
    context.logger.info('Found project name: $projectName');
  } else {
    throw Exception('pubspec.yaml not found. Ensure you are in a Flutter project directory.');
  }

  // ! Read organization name from android/app/build.gradle
  final buildGradle = File('android/app/build.gradle');
  if (buildGradle.existsSync()) {
    final lines = buildGradle.readAsLinesSync();
    final applicationIdLine = lines.firstWhere((line) => line.contains('applicationId'));
    final regex = RegExp(r'(?<=")[^"]+(?=")');
    final match = regex.stringMatch(applicationIdLine);
    if (match == null) {
      throw Exception('applicationId cannot be not found in android/app/build.gradle');
    }

    final orgName = match.split('.').take(2).join(".");
    context.vars['org_name'] = orgName;
    context.logger.info('Found organization name: $orgName');
  } else {
    throw Exception(
        'android/app/build.gradle not found. Ensure you are in a Flutter project directory.');
  }
}
