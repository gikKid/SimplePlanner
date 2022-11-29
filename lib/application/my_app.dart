import 'package:flutter/material.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/widgets/login_widget.dart';
import 'package:todo_application/ui/widgets/starting_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titleNameApp,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == startingWidgetRouterName) {
          return PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  StartingWidget.create());
        } else if (settings.name == loginWidgetRouterName) {
          return PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  LoginWidget.create());
        }
      },
      theme: ThemeData(primaryColor: Colors.orange),
      home: StartingWidget.create(), //FIXING: Make loader widget w/ logic if user was logged or entered
    );
  }
}
