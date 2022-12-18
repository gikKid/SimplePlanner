import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'package:todo_application/ui/widgets/screens/note/note_widget.dart';

import '../../../../domain/constants.dart';
import '../../../../domain/data_providers/box_manager.dart';
import '../../../../domain/global_functions.dart';
import '../../../../entity/note.dart';

class NoteViewModel extends ChangeNotifier {
  NoteWidgetConfiguration configuration;
  late final Future<Box<Note>> _notesBox;
  var note = Note(name: '', mainText: '', dayRating: '', images: []);
  String dayRatingValue = dropDownButtonData.first;

  NoteViewModel({required this.configuration}) {
    setup();
  }

  void setup() async {
    _notesBox = BoxManager.shared.openNotesBox();
    final savingNote = (await _notesBox).getAt(configuration.noteIndex);
    if (savingNote != null) note = savingNote;
    getDropDownValue();
    notifyListeners();
  }

  void getDropDownValue() {
    for (var value in dropDownButtonData) {
      if (value == note.dayRating) {
        dayRatingValue = value;
      }
    }
  }

  void dayRatingValueChanged(String? value) {
    note.dayRating = value!;
    dayRatingValue = value;
    notifyListeners();
  }

  Future pickImageButtonTapped(ImageSource source, BuildContext context) async {
    try {
      // var image = await ImagePicker().pickImage(source: source);
      // if (image == null) return;

      // final imageTemporary = File(image.path);
      //  Uint8List _image = await pickedImage.readAsBytes();
      // images.add(imageTemporary);

      // for use Image.file(image,width: ,height:)
      // final mockImage = Image.asset("assets/images/default.png");

      //FIXING: - MOCK DATA FOR TEST !!! IN FUTURE UNCOMMENT BELOW TO GET IMAGE FROM DEVICE
      final mockBytesDataImage =
          await rootBundle.load("assets/images/default.png");
      Uint8List mockBytesImage = mockBytesDataImage.buffer.asUint8List();
      note.images.add(mockBytesImage);
      Navigator.of(context).pop();
      notifyListeners();
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (_) => createErrorAlert("$e", context),
          barrierDismissible: false);
    }
  }

  @override
  void dispose() async {
    note.save();
    await BoxManager.shared.closeBox((await _notesBox));
    super.dispose();
  }
}

class NoteWidgetModelProvider extends InheritedNotifier {
  final NoteViewModel model;
  final Widget child;

  const NoteWidgetModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  static NoteWidgetModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NoteWidgetModelProvider>();
  }

  static NoteWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NoteWidgetModelProvider>();
  }

  static NoteWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<NoteWidgetModelProvider>()
        ?.widget;
    return widget is NoteWidgetModelProvider ? widget : null;
  }
}
