import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/size_config.dart';
import 'dart:io';
import 'dart:async';

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {
  var dropDownValue = dropDownButtonData.first;
  List<File> images = [];
  List<String> mockImages = [];

  void changeDayRatingValue(String? value) {
    if (value != null) {
      dropDownValue = value;
      notifyListeners();
    }
  }

  Future pickImageButtonTapped(ImageSource source, BuildContext context) async {
    try {
      //FIXING: - MOCK DATA FOR TEST !!! IN FUTURE UNCOMMENT BELOW TO GET IMAGE FROM DEVICE
      // var image = await ImagePicker().pickImage(source: source);
      // if (image == null) return;

      // final imageTemporary = File(image.path);
      // images.add(imageTemporary);

      // for use Image.file(image,width: ,height:)
      mockImages.add("assets/images/default.png");
      notifyListeners();
    } on PlatformException catch (e) {
      //FUTURE: - Show error alert to user!!!
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
        floatingActionButton: FloatingActionButton(
            tooltip: done,
            backgroundColor: Colors.orange,
            onPressed: (() => {}),
            child: const Icon(Icons.done)),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(context, 20)),
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                  height: SizeConfig(
                  mediaQueryData: MediaQuery.of(context)).screenHeight() * 0.08),
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
                    return Image.asset(model.mockImages[index],
                    height: getProportionateScreenHeight(context, 100),
                    width: getProportionateScreenWidth(context, 100),);
                  },
                  childCount: model.mockImages.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,)
                    )
          ]),
        )));
  }
}

class _NameTextFieldWidget extends StatelessWidget {
  const _NameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        labelText: "Title",
        helperText: "By default it will be set current date",
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _NoteMainTextWidget extends StatelessWidget {
  const _NoteMainTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            hintText: "Write what you want here",
            border: OutlineInputBorder()),
        maxLines: null,
        minLines: null);
  }
}

class _DayRatingWidget extends StatelessWidget {
  const _DayRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return Row(
      children: [
        const Text("How was your day?"),
        const SizedBox(
          width: 30,
        ),
        DropdownButton<String>(
            value: model.dropDownValue,
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

    return Column(
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () async => await model.pickImageButtonTapped(
                    ImageSource.gallery, context),
                child: const Text(
                  pickGallery,
                  style: TextStyle(color: Colors.grey),
                )),
            TextButton(
                onPressed: () async => await model.pickImageButtonTapped(
                    ImageSource.camera, context),
                child: const Text(
                  pickCamera,
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
