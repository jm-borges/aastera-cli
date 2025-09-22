import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> initFirebaseCore() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await requestNotificationPermissions();
}

Future<void> requestNotificationPermissions() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    sound: true,
    badge: true,
    alert: true,
    provisional: true,
  );

  switch (settings.authorizationStatus) {
    case AuthorizationStatus.authorized:
      _handleUserGrantedPermissions();
      break;
    case AuthorizationStatus.provisional:
      _handleUserGrantedProvisionalPermissions();
      break;
    default:
      _handleUserDeniedPermissions();
  }
}

void _handleUserGrantedPermissions() {}
void _handleUserGrantedProvisionalPermissions() {}
void _handleUserDeniedPermissions() {}
