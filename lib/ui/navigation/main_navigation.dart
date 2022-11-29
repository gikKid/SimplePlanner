import 'package:flutter/cupertino.dart';
import 'package:todo_application/domain/constants.dart';

class MainNavigation { //FIXING: fix navigation push
  static void showLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(loginWidgetRouterName); 
  }

  static void showRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(registerWidgetRouterName);
  }
}
