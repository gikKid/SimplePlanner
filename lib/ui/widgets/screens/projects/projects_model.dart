import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/domain/data_providers/box_manager.dart';
import 'package:todo_application/ui/navigation/main_navigation.dart';

import '../../../../entity/project.dart';

class ProjectsViewModel extends ChangeNotifier {
  late final Future<Box<Project>> _projectsBox;
  ValueListenable<Object>? _listenableBox;
  var _projects = <Project>[];
  List<Project> get projects => _projects.toList();
  bool isSelectionMode = false;
  bool selectAll = false;
  List<int> selectedProjects = [];
  List<int> selectedKeys = [];

  ProjectsViewModel() {
    setup();
  }

  void setup() async {
    _projectsBox = BoxManager.shared.openProjectsBox();
    await _readProjectsFromHive();
    _listenableBox = (await _projectsBox).listenable();
    _listenableBox?.addListener(() => _readProjectsFromHive());
  }

  Future<void> _readProjectsFromHive() async {
    _projects = (await _projectsBox).values.toList();
    notifyListeners();
  }

  void userTapCreateProject(BuildContext context) {
    MainNavigation.showCreateProjectScreen(context);
  }

  void userTapSelectAll() {
    if (selectAll) {
      selectedProjects.clear();
      selectedKeys.clear();
    } else {
      var index = 1;
      for (var note in _projects) {
        if (!selectedKeys.contains(note.key)) {
          selectedKeys.add(note.key);
        }
        if (!selectedProjects.contains(index)) {
          selectedProjects.add(index);
        }
        index++;
      }
    }
    selectAll = !selectAll;
    notifyListeners();
  }

  void userSelectProject(BuildContext context, int index) {
    if (!isSelectionMode) {
      //FUTURE: show project screen
      return;
    }
    if (selectedProjects.contains(index)) {
      selectedProjects.remove(index);
      final selectedProject = _projects[index - 1];
      selectedKeys.remove(selectedProject.key);
      if (selectedProjects.isEmpty) {
        selectAll = false;
      }
    } else {
      final project = _projects[index - 1];
      selectedKeys.add(project.key);
      selectedProjects.add(index);
    }
    notifyListeners();
  }

  void userTapSelectButton() {
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }

  void userTapCancelButton() {
    isSelectionMode = !isSelectionMode;
    selectedProjects.clear();
    selectedKeys.clear();
    notifyListeners();
  }

    void userTapDeleteProjects() async {
    final box = await _projectsBox;
    for (var key in selectedKeys) {
      box.delete(key);
    }
    selectedProjects.clear();
    selectedKeys.clear();
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }

  @override
  void dispose() async {
    _listenableBox?.removeListener(() => _readProjectsFromHive());
    BoxManager.shared.closeBox((await _projectsBox));
    super.dispose();
  }
}

class ProjectsWidgetModelProvider extends InheritedNotifier {
  final ProjectsViewModel model;
  final Widget child;

  const ProjectsWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static ProjectsWidgetModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProjectsWidgetModelProvider>();
  }

  static ProjectsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProjectsWidgetModelProvider>();
  }

  static ProjectsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ProjectsWidgetModelProvider>()
        ?.widget;
    return widget is ProjectsWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ProjectsWidgetModelProvider oldWidget) {
    return false;
  }
}
