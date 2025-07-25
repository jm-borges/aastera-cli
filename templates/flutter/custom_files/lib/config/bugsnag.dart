import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:flutter/foundation.dart';
import 'config.dart';

Future<void> initializeBugsnag() async {
  if (!kIsWeb &&
      Config.appIsInProduction() &&
      Config.bugsnagApiKey.isNotEmpty) {
    await bugsnag.start(apiKey: Config.bugsnagApiKey);
  }
}
