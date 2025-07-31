import '../main.dart';
import '../utilities/global.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

Future<void> initializeLocalAuth() async {
  if (!kIsWeb) {
    auth = LocalAuthentication();
    canAuthenticateWithBiometrics = await auth!.canCheckBiometrics;
    availableBiometrics = await auth!.getAvailableBiometrics();

    printOnDebug(
      'Device can check biometrics: ${await auth!.canCheckBiometrics}',
    );
    printOnDebug(
      'Device can authenticate with biometrics: $canAuthenticateWithBiometrics',
    );
    printOnDebug('Available Biometrics: $availableBiometrics');
  } else {
    auth = null;
  }
}
