// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../exceptions/known_exception.dart';
import '../providers/loading_indicator.dart';
import 'snackbars.dart';

/// Executes a given asynchronous action while showing a loading indicator.
///
/// This function wraps an asynchronous action, displaying a loading indicator
/// while the action is being executed. It handles known exceptions by treating
/// them and showing an error snackbar with a specific message. For any other
/// exceptions, it prints the error in debug mode and shows a generic error snackbar.
///
/// - Parameters:
///   - action: The asynchronous action to be executed.
///   - context: The BuildContext used to show the error snackbar.
///
/// - Throws: Any exception that is not a KnownException is caught and logged,
///   and a generic error message is displayed in a snackbar.
Future<void> executeAction(
  Future<void> Function() action,
  BuildContext context,
) async {
  LoadingIndicator loadingIndicator = Provider.of<LoadingIndicator>(
    context,
    listen: false,
  );
  try {
    loadingIndicator.show();
    await action();
  } on KnownException catch (e, stackTrace) {
    treatException(e, stackTrace);
    showErrorSnackBar(context, e.toString());
  } catch (e, stackTrace) {
    printOnDebug([e, stackTrace]);
    showErrorSnackBar(context, 'Houve um erro ao realizar essa ação');
  } finally {
    loadingIndicator.hide();
  }
}

Future<void> executeFormAction(
  GlobalKey<FormState> key,
  Future<void> Function() action,
  BuildContext context, {
  String? errorMessage,
}) async {
  if (key.currentState?.validate() ?? false) {
    await executeAction(action, context);
  } else {
    showErrorSnackBar(
      context,
      errorMessage ?? 'Existem problemas nos campos do formulário',
    );
  }
}

/// Prints debug messages to the console if the app is in debug mode.
///
/// If the app is not in debug mode, debug messages will not be printed.
///
/// [messages] A list of objects to be printed. Each object's string representation
/// is printed to the console.
void printOnDebug(dynamic messages) {
  if (kDebugMode) {
    if (messages is Iterable) {
      for (var message in messages) {
        if (message != null) {
          print(message.toString());
        } else {
          print('null');
        }
      }
    } else {
      print(messages.toString());
    }
  }
}

void treatException(dynamic e, StackTrace stackTrace) {
  printOnDebug(e);
  bool shouldNotify =
      (e is KnownException && e.shouldNotify) || e is! KnownException;

  if (Config.appIsInProduction() && shouldNotify) {
    bugsnag.notify(e, stackTrace);
  }
}

Future<bool> internetConnectionExists() async {
  if (kIsWeb) {
    return _hasNetworkWeb();
  } else {
    return _hasNetworkMobile();
  }
}

Future<bool> _hasNetworkWeb() async {
  try {
    final result = await http.get(Uri.parse('example.com'));
    if (result.statusCode == 200) return true;
  } on SocketException catch (_) {}
  return false;
}

Future<bool> _hasNetworkMobile() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {}
  return false;
}

/// Handles exceptions and displays an error message.
///
/// If [overrideMessage] is provided, it will be used as the error message instead of the exception's message.
///
/// If the app is in production mode, the error is also reported to Bugsnag.
///
/// [exception] The exception to handle.
/// [context] The build context to display the error message.
/// [overrideMessage] An optional message to override the exception's message.
/// [displayErrorMessage] Optionally shows snackbar of error to user.
/// [notify] Optionally notify the error to an external source.
void handleError(
  Exception exception,
  BuildContext context, {
  String? overrideMessage,
  bool displayErrorMessage = true,
  bool notify = false,
}) {
  final message = _constructErrorMessage(exception, overrideMessage);

  _debugPrint(message);
  if (notify) _reportToBugsnag(message);
  if (displayErrorMessage) _displayErrorMessage(context, message);
}

/// Constructs the error message.
///
/// If [overrideMessage] is provided, it will be used as the error message instead of the exception's message.
///
/// [exception] The exception.
/// [overrideMessage] An optional message to override the exception's message.
String _constructErrorMessage(Exception exception, String? overrideMessage) {
  final message = overrideMessage ?? exception.toString();

  // Stripping 'Exception: ' if present
  return message.startsWith('Exception: ')
      ? message.substring('Exception: '.length)
      : message;
}

/// Prints debug messages to the console if the app is in debug mode.
///
/// [message] The message to print.
void _debugPrint(String message) {
  printOnDebug([message]);
}

/// Reports the error to Bugsnag if the app is in production mode.
///
/// [message] The error message.
void _reportToBugsnag(String message) {
  if (Config.appIsInProduction()) {
    // Notify Bugsnag
  }
}

/// Displays the error message in a snackbar.
///
/// [context] The build context.
/// [message] The error message to display.
void _displayErrorMessage(BuildContext context, String message) {
  showErrorSnackBar(context, message);
}

String getExceptionMessage(dynamic e) {
  String errorMessage = e.toString();
  errorMessage = errorMessage.split(": ")[1];

  return errorMessage;
}
