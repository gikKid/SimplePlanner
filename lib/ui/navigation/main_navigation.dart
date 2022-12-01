import 'package:todo_application/domain/constants.dart';
import 'package:flutter/material.dart';

class MainNavigation {
  static void showLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(loginWidgetRouterName);
  }

  static void showRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(registerWidgetRouterName);
  }

  static void showMainScreen(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(mainWidgetRouterName, (route) => false);
  }
}
