import 'package:hive/hive.dart';
import 'package:todo_application/domain/constants.dart';

part "project.g.dart";

@HiveType(typeId: projectTypeId)
class Project extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isFavorite;
  @HiveField(2)
  String hexColor;
  @HiveField(3)
  List<ProjectCategory> categories;
  @HiveField(4)
  List<ProjectTask> commonTasks;

  Project({
    required this.name,
    required this.isFavorite,
    required this.hexColor,
    required this.categories,
    required this.commonTasks,
  });
}

class ProjectCategory {
  String name;
  List<ProjectTask> tasks;

  ProjectCategory({
    required this.name,
    required this.tasks,
  });
}

class ProjectTask {
  String name;
  String? description;
  bool isFinished;
  int priority;
  DateTime? time;
  DateTime timeFinished;

  ProjectTask({
    required this.name,
    required this.description,
    required this.isFinished,
    required this.priority,
    required this.time,
    required this.timeFinished,
  });
}
