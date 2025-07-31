// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'firebase_actions.dart';
import 'firebase_notifications.dart';
import '../../utilities/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Utilitário genérico para log e ação
Future<void> processIncomingMessage({
  required String origin,
  required Map<String, dynamic> data,
  bool isRemoteMessage = true,
}) async {
  printOnDebug(['FIREBASE MESSAGE RECEIVED FROM $origin ======> $data']);

  final action = data['action'];
  //final context = navigatorKey.currentContext;

  if (shouldDisplayNotification(action) && isRemoteMessage) {
    await displayNotification(RemoteMessage(data: data));
  }
}

/// Execução direta para mensagens com ação
Future<void> handleActionMessage(
  String origin,
  Map<String, dynamic> data,
) async {
  printOnDebug(['FIREBASE MESSAGE RECEIVED ON $origin ======> $data']);
  if (messageHasActionFromData(data)) {
    executeAnActionFromData(data);
  }
}

bool shouldDisplayNotification(String action) =>
    (action != 'create_check_in_record' &&
        action != 'update_check_in_record' &&
        kIsWeb) ||
    action == 'update_chat_screen';

void executeAnAction(RemoteMessage message) {
  String action = message.data['action'];
  Map<String, dynamic> data = jsonDecode(message.data['data']);
  executeInformedAction(action, data);
}

void executeAnActionFromData(Map<String, dynamic> data) {
  executeInformedAction(data['action'], data);
}

bool messageHasAction(RemoteMessage message) {
  return message.data.containsKey('action');
}

/// Versões sem RemoteMessage para reuso
bool messageHasActionFromData(Map<String, dynamic> data) {
  return data['action'] != null;
}
