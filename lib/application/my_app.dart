import 'package:flutter/material.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/widgets/sreens/login_widget.dart';
import 'package:todo_application/ui/widgets/sreens/main_widget.dart';
import 'package:todo_application/ui/widgets/sreens/onboarding_widget.dart';
import 'package:todo_application/ui/widgets/sreens/register_widget.dart';
import 'package:todo_application/ui/widgets/sreens/starting_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
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
        } else if (settings.name == mainWidgetRouterName) {
          return PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  MainWidget.create());
        } else if (settings.name == registerWidgetRouterName) {
          return PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  RegisterWidget.create());
        }

      },
      theme: ThemeData(
          primaryColor: Colors.orange, 
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color(0xFF757575)),
          bodyText2: TextStyle(color: Color(0xFF757575) )
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity
          ),
      darkTheme: ThemeData(primaryColor: Colors.orange,backgroundColor: Colors.black),
      home:OnBoardingWidget.create(),
    );
  }
}
