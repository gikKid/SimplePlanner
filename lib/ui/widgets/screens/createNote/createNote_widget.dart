import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/data_providers/box_manager.dart';
import 'package:todo_application/domain/global_functions.dart';
import 'package:todo_application/ui/widgets/components/noteBody.dart';

import '../../../../entity/note.dart';

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {
  List<Uint8List> images = [];
  List<Uint8List> mockImages = [];
  String? nameText;
  String? _mainText;
  String? get mainText => _mainText;
  set mainText(String? value) {
    if (mainText == null) {
      _mainText = value;
      notifyListeners();
      return;
    }
    _mainText = value;
  }

  String dayRatingValue = dropDownButtonData.first;
  bool get isValid => mainText != null;
  

  void changeDayRatingValue(String? value) {
    if (value != null) {
      dayRatingValue = value;
      notifyListeners();
    }
  }

  void createNote(BuildContext context) async {
    if (mainText != null) {
      final note = Note(
          name: nameText == null ? createStringDateNow() : nameText!,
          mainText: mainText!,
          dayRating: dayRatingValue,
          images: mockImages);

      final box = await BoxManager.shared.openNotesBox();
      await box.add(note);
      await BoxManager.shared.closeBox(box);
      Navigator.of(context).pop();
    }
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
      mockImages.add(mockBytesImage);
      Navigator.of(context).pop();
      notifyListeners();
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (_) => createErrorAlert("$e", context),
          barrierDismissible: false);
    }
  }
}

//MARK: WIDGET

class CreateNote extends StatelessWidget {
  const CreateNote({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const CreateNote(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(createNoteTooltip),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      floatingActionButton: model.isValid
          ? FloatingActionButton(
              tooltip: done,
              backgroundColor: Colors.orange,
              onPressed: (() => model.createNote(context)),
              child: const Icon(Icons.done))
          : null,
      body: NoteBody(
          images: model.mockImages,
          nameTextFieldText: model.nameText ?? "",
          nameTextFieldChanged: ((value) {
            model.nameText = value;
          }),
          mainTextFieldText: model.mainText ?? "",
          mainTextFieldChanged: ((value) {
            model.mainText = value;
          }),
          dayRatingTitle: dayRatingTitle,
          dayRatingValue: model.dayRatingValue,
          dropDownValueChanged: ((value) {
            model.changeDayRatingValue(value);
          }),
          pickGalleryButtonTapped: ((imageSource, context) {
            model.pickImageButtonTapped(imageSource, context);
            return null;
          }),
          pickCameraButtonTapped: ((imageSource, context) {
            model.pickImageButtonTapped(imageSource, context);
            return null;
          })),
    );
  }
}