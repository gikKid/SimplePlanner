import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/domain/data_providers/box_manager.dart';
import 'package:todo_application/ui/widgets/screens/project/project_widget.dart';
import '../../../../entity/project.dart';

class ProjectViewModel extends ChangeNotifier {
  ProjectWidgetConfiguration configuration;
  late final Future<Box<Project>> _projectsBox;
  var project = Project(
      name: "",
      isFavorite: false,
      hexColor: "",
      categories: [],
      commonTasks: []);
  TextEditingController dateController = TextEditingController();

  ProjectViewModel({
    required this.configuration,
  }) {
    _setup();
  }

  void _setup() async {
    _projectsBox = BoxManager.shared.openProjectsBox();
    final savingProject =
        (await _projectsBox).getAt(configuration.projectIndex);
    if (savingProject != null) project = savingProject;

    dateController.text = "";

    notifyListeners();
  }

  @override
  void dispose() async {
    project.save();
    await BoxManager.shared.closeBox((await _projectsBox));
    super.dispose();
  }
}

class ProjectWidgetModelProvider extends InheritedNotifier {
  final ProjectViewModel model;
  final Widget child;

  const ProjectWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static ProjectWidgetModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProjectWidgetModelProvider>();
  }

  static ProjectWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProjectWidgetModelProvider>();
  }

  static ProjectWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ProjectWidgetModelProvider>()
        ?.widget;
    return widget is ProjectWidgetModelProvider ? widget : null;
  }
}
