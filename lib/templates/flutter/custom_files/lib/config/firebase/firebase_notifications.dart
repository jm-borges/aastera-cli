import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_listeners.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeLocalNotifications() async {
  final initializationSettings = _getInitializationSettings();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onForegroundTapNotification,
    onDidReceiveBackgroundNotificationResponse: null,
  );
}

InitializationSettings _getInitializationSettings() {
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iOSSettings = DarwinInitializationSettings();

  return const InitializationSettings(
    android: androidSettings,
    iOS: iOSSettings,
  );
}

Future<void> displayNotification(RemoteMessage message) async {
  if (!kIsWeb && message.notification != null) {
    final androidDetails = const AndroidNotificationDetails(
      'main_channel',
      'main_channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformDetails,
      payload: message.data.toString(),
    );
  }
}
