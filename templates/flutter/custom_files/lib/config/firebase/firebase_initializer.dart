import 'firebase_core_setup.dart';
import 'firebase_messaging_setup.dart';

Future<void> initializeFirebase() async {
  await initFirebaseCore();
  await initFirebaseMessaging();
  await handleInitialFirebaseMessage();
}
