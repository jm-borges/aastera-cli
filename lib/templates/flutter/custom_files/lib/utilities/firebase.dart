import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import 'global.dart';

/// Updates the Firebase Cloud Messaging (FCM) token for the current user.
///
/// This method retrieves the device's FCM token and updates it in the backend
/// using the `UserService`. The method handles token retrieval differently based
/// on the platform:
///
/// - **iOS**: Attempts to retrieve the Apple Push Notification Service (APNS)
///   token using `getAPNSToken`. If a valid token is retrieved, it logs the
///   APNS token for debugging purposes. If the token is `null`, the method
///   returns early without further action.
///
/// - **Other Platforms**: Retrieves the FCM token using `getToken`.
///
/// Once the FCM token is retrieved, it is sent to the backend by calling
/// `UserService.update`, which updates the user's record with the new token.
///
/// The FCM token is used to send push notifications to the device.
///
/// This method is asynchronous and must be awaited to ensure the token is
/// properly updated.
///
/// Returns:
/// - `Future<void>`: A `Future` that completes when the token has been successfully updated.
Future<void> updateFCMToken(UserProvider userProvider) async {
  if (!kIsWeb) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        printOnDebug('APNS Token: $apnsToken');
      } else {
        return;
      }
    }

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      await UserService.update({'fcm_token': fcmToken}, userProvider.id!);
    }
  }
}
