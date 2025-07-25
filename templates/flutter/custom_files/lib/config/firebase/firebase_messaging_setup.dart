import 'firebase_notifications.dart';
import 'firebase_listeners.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

Future<void> initFirebaseMessaging() async {
  if (kIsWeb) {
    html.window.onMessage.listen(onWebMessage);
  } else {
    await initializeLocalNotifications();
  }

  _setupMessageListeners();
}

void _setupMessageListeners() {
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  FirebaseMessaging.onMessage.listen(onMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
}

Future<void> handleInitialFirebaseMessage() async {
  final message = await FirebaseMessaging.instance.getInitialMessage();
  await onInitialMessage(message);
}
