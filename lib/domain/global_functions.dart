import 'package:flutter/material.dart';
import 'constants.dart';

AlertDialog createErrorAlert(String errorText, BuildContext context) {
  return AlertDialog(
    title: const Text(errorTitle),
    content: Text(errorText),
    actions: <Widget>[
      TextButton(
        child: const Text(errorConfirmTitleAction),
        onPressed: () => Navigator.of(context).pop(),
      )
    ],
    elevation: 24.0,
  );
}

String createStringDateNow() {
  DateTime dateToday = DateTime.now();
  String date = dateToday.toString().substring(0, 10);
  return date;
}
