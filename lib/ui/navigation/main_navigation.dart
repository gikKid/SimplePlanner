import 'package:todo_application/domain/constants.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/ui/widgets/screens/note/note_widget.dart';

class MainNavigation {
  static void showLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(loginWidgetRouterName);
  }

  static void showRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(registerWidgetRouterName);
  }

  static void showMainScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(mainWidgetRouterName, (route) => false);
  }

  static void showStartingScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(startingWidgetRouterName, (route) => false);
  }

  static void showBlogScreen(BuildContext context) {
    Navigator.of(context).pushNamed(blogWidgetRouterName);
  }

  static void showSettingsScreen(BuildContext context) {
    Navigator.of(context).pushNamed(settingsWidgetRouterName);
  }

  static void showCreateNoteScreen(BuildContext context) {
    Navigator.of(context).pushNamed(createNoteRouterName);
  }

  static void showNoteScreen(BuildContext context, NoteWidgetConfiguration configuration) {
    Navigator.of(context)
        .pushNamed(noteWidgetRouteName, arguments: configuration);
  }
}
