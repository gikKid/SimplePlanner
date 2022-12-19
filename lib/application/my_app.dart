import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/data_providers/dark_theme_provider.dart';
import 'package:todo_application/domain/theme_data.dart';
import 'package:todo_application/ui/widgets/screens/blog/blog_widget.dart';
import 'package:todo_application/ui/widgets/screens/createNote/createNote_widget.dart';
import 'package:todo_application/ui/widgets/screens/createProject/createProject_widget.dart';
import 'package:todo_application/ui/widgets/screens/login/login_widget.dart';
import 'package:todo_application/ui/widgets/screens/main/main_widget.dart';
import 'package:todo_application/ui/widgets/screens/note/note_widget.dart';
import 'package:todo_application/ui/widgets/screens/onBoarding/onboarding_widget.dart';
import 'package:todo_application/ui/widgets/screens/project/project_widget.dart';
import 'package:todo_application/ui/widgets/screens/projects/projects_widget.dart';
import 'package:todo_application/ui/widgets/screens/register/register_widget.dart';
import 'package:todo_application/ui/widgets/screens/settings/settings_widget.dart';
import 'package:todo_application/ui/widgets/screens/starting/starting_widget.dart';

//MARK: WIDGET

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => themeChangeProvider)],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
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
              } else if (settings.name == blogWidgetRouterName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const BlogWidget());
              } else if (settings.name == settingsWidgetRouterName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SettingsWidget.create());
              } else if (settings.name == createNoteRouterName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        CreateNote.create());
              } else if (settings.name == noteWidgetRouteName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                  final configuration =
                      settings.arguments as NoteWidgetConfiguration;
                  return NoteWidget(configuration: configuration);
                });
              } else if (settings.name == projectsWidgetRouteName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const ProjectsWidget());
              } else if (settings.name == createProjectRouteName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        CreateProjectWidget.create());
              } else if (settings.name == projectRouteName) {
                return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                  final configuration =
                      settings.arguments as ProjectWidgetConfiguration;
                  return ProjectWidget(configuration: configuration);
                });
              }
            },
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: OnBoardingWidget.create(),
          );
        },
      ),
    );
  }
}
