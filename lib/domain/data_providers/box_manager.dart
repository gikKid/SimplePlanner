import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/entity/note.dart';
import 'package:todo_application/entity/project.dart';

class BoxManager {
  final Map<String, int> _boxCounter = <String, int>{};

  static final BoxManager shared = BoxManager._();

  BoxManager._();

  Future<Box<Note>> openNotesBox() async {
    return _openBox("notes_box", notesTypeId, NoteAdapter());
  }

  Future<Box<Project>> openProjectsBox() {
    return _openBox("projects_box", projectTypeId, ProjectAdapter());
  }

  Future<Box<T>> _openBox<T>(
      String boxName, int typeId, TypeAdapter<T> adapter) async {
    if (Hive.isBoxOpen(boxName)) {
      final count = _boxCounter[boxName] ?? 1;
      _boxCounter[boxName] = count + 1;
      return Hive.box(boxName);
    }

    _boxCounter[boxName] = 1;

    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(boxName);
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }

    var count = _boxCounter[box.name] ?? 1;
    count -= 1;
    if (count > 0) return;

    _boxCounter.remove(box.name);

    await box.compact();
    await box.close();
  }
}
