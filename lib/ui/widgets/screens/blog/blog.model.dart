// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../domain/data_providers/box_manager.dart';
import '../../../../entity/note.dart';
import '../../../navigation/main_navigation.dart';

class BlogViewModel extends ChangeNotifier {
  late final Future<Box<Note>> _notesBox;
  ValueListenable<Object>? _listenableBox;
  var _notes = <Note>[];
  List<Note> get notes => _notes.toList();
  bool isSelectionMode = false;
  bool selectAll = false;
  List<int> selectedNotes = [];

  BlogViewModel() {
    _setup();
  }

  void _setup() async {
    _notesBox = BoxManager.shared.openNotesBox();
    await _readNotesFromHive();
    _listenableBox = (await _notesBox).listenable();
    _listenableBox?.addListener(() => _readNotesFromHive());
  }

  Future<void> _readNotesFromHive() async {
    _notes = (await _notesBox).values.toList();
    notifyListeners();
  }

  void userTapCreateNoteButton(BuildContext context) {
    MainNavigation.showCreateNoteScreen(context);
  }

  void userTapSelectButton() {
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }

  void userSelectNote(int index) {
    if (!isSelectionMode) return;
    if (selectedNotes.contains(index)) {
      selectedNotes.remove(index);
      notifyListeners();
      return;
    }
    selectedNotes.add(index);
    notifyListeners();
  }

  void userTapCancelButton() {
    isSelectionMode = !isSelectionMode;
    selectedNotes.clear();
    notifyListeners();
  }

  void userTapDeleteNotes() async {
    final box = await _notesBox;
    for (var index in selectedNotes) {
      box.deleteAt(index - 1);
    }
    selectedNotes.clear();
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }

  @override
  void dispose() async {
    _listenableBox?.removeListener(() => _readNotesFromHive());
    await BoxManager.shared.closeBox((await _notesBox));
    super.dispose();
  }
}

class BlogWidgetModelProvider extends InheritedNotifier {
  final BlogViewModel model;
  final Widget child;
  const BlogWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static BlogWidgetModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlogWidgetModelProvider>();
  }

  static BlogWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlogWidgetModelProvider>();
  }

  static BlogWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<BlogWidgetModelProvider>()
        ?.widget;
    return widget is BlogWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(BlogWidgetModelProvider oldWidget) {
    return false;
  }
}
