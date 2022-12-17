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
import 'package:todo_application/domain/size_config.dart';

import '../../../../entity/note.dart';

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {
  List<Uint8List> images = [];
  List<Uint8List> mockImages = [];
  String? nameText;
  String? mainText;
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
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(context, 20)),
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                  height: SizeConfig(mediaQueryData: MediaQuery.of(context))
                          .screenHeight() *
                      0.08),
              const _NameTextFieldWidget(),
              const SizedBox(height: 30),
              const _NoteMainTextWidget(),
              const SizedBox(height: 30),
              const _DayRatingWidget(),
              const SizedBox(height: 30),
              const _ImagesWidget()
            ])),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Image.memory(
                      model.mockImages[index],
                      height: getProportionateScreenHeight(context, 100),
                      width: getProportionateScreenWidth(context, 100),
                    );
                  },
                  childCount: model.mockImages.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ))
          ]),
        )));
  }
}

class _NameTextFieldWidget extends StatelessWidget {
  const _NameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return TextField(
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          labelText: "Title",
          helperText: "By default it will be set current date",
          border: OutlineInputBorder()),
      onChanged: (value) => model.nameText = value,
    );
  }
}

class _NoteMainTextWidget extends StatelessWidget {
  const _NoteMainTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return TextField(
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            hintText: "Write what you want here",
            border: OutlineInputBorder()),
        maxLines: null,
        minLines: null,
        onChanged: (value) => model.mainText = value);
  }
}

class _DayRatingWidget extends StatelessWidget {
  const _DayRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return Row(
      children: [
        const Text(dayRatingTitle),
        const SizedBox(
          width: 30,
        ),
        DropdownButton<String>(
            value: model.dayRatingValue,
            items: dropDownButtonData
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) => model.changeDayRatingValue(value),
            style: const TextStyle(color: Colors.blue)),
      ],
    );
  }
}

class _ImagesWidget extends StatelessWidget {
  const _ImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          backgroundColor: Colors.grey,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                        onPressed: () async =>
                            await model.pickImageButtonTapped(
                                ImageSource.gallery, context),
                        child: const Text(
                          pickGallery,
                        )),
                    TextButton(
                        onPressed: () async => await model
                            .pickImageButtonTapped(ImageSource.camera, context),
                        child: const Text(
                          pickCamera,
                        )),
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange)),
      child: const Text(addImage),
    );
  }
}
