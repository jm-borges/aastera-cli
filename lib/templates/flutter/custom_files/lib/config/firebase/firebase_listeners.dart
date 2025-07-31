// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'firebase_actions.dart';
import 'firebase_helpers.dart';
import 'firebase_listener_helpers.dart';
import '../../utilities/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universal_html/html.dart' as html;

/// App aberto por notificação
Future<void> onMessageOpenedApp(RemoteMessage message) async {
  await handleActionMessage('OPENED APP', message.data);
}

/// App iniciado por notificação
Future<void> onInitialMessage(RemoteMessage? message) async {
  if (message != null) {
    await handleActionMessage('INITIAL MESSAGE', message.data);
  }
}

/// Notificação recebida com app aberto
Future<void> onMessage(RemoteMessage message) async {
  await processIncomingMessage(origin: 'FOREGROUND', data: message.data);
}

/// Notificação recebida em segundo plano
@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  await processIncomingMessage(origin: 'BACKGROUND', data: message.data);
}

/// Notificação recebida no Web
Future<void> onWebMessage(html.MessageEvent event) async {
  final Map<String, dynamic> eventData = jsonDecode(event.data.toString());
  printOnDebug(['FIREBASE MESSAGE RECEIVED ON WEB ======> $eventData']);

  if (eventData['data'] != null) {
    await processIncomingMessage(
      origin: 'WEB',
      data: Map<String, dynamic>.from(eventData['data']),
      isRemoteMessage: false,
    );
  }
}

/// Toque na notificação em primeiro plano (mobile)
Future<void> onForegroundTapNotification(NotificationResponse? response) async {
  final payload = response?.payload;
  if (payload != null) {
    final convertedPayload = convertPayload(payload);
    executeInformedAction(convertedPayload['action'], convertedPayload['data']);
  }
}
