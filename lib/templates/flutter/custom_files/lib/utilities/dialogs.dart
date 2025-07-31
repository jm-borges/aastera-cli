import 'package:flutter/material.dart';
import 'styles.dart';

Future<bool> getConfirmation({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  return await showConfirmationDialog(
    context: context,
    title: title,
    message: message,
  );
}

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (dialogContext) => confirmationDialogBuilder(
          dialogContext: dialogContext,
          title: title,
          message: message,
        ),
      ) ??
      false;
}

Widget confirmationDialogBuilder({
  required BuildContext dialogContext,
  required String title,
  required String message,
}) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: buildConfirmationDialogActions(dialogContext),
  );
}

List<Widget> buildConfirmationDialogActions(BuildContext context) {
  return [
    TextButton(
      onPressed: () => Navigator.of(context).pop(false),
      child: Text('Não'),
    ),
    TextButton(
      onPressed: () => Navigator.of(context).pop(true),
      child: Text('Sim'),
    ),
  ];
}

Future<void> showFeatureUnreleasedDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Essa funcionalidade ainda não está disponível.'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Avisaremos assim que você puder utilizar!'),
          const SizedBox(height: 15),
          ElevatedButton(
            style: buildStdButtonStyle(),
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
