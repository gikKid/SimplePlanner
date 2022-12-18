import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/constants.dart';
import '../../../domain/size_config.dart';

class NoteBody extends StatelessWidget {
  final List<Uint8List> images;
  final String nameTextFieldText;
  final Function(String value) nameTextFieldChanged;
  final String mainTextFieldText;
  final Function(String value) mainTextFieldChanged;
  final String dayRatingTitle;
  final String? dayRatingValue;
  final Function(String? value) dropDownValueChanged;
  final Future<dynamic>? Function (ImageSource source, BuildContext context) pickGalleryButtonTapped;
  final Future<dynamic>? Function (ImageSource source, BuildContext context) pickCameraButtonTapped;

  const NoteBody(
      {super.key,
      required this.images,
      required this.nameTextFieldText,
      required this.nameTextFieldChanged,
      required this.mainTextFieldText,
      required this.mainTextFieldChanged,
      required this.dayRatingTitle,
      required this.dayRatingValue, required this.dropDownValueChanged, required this.pickGalleryButtonTapped, required this.pickCameraButtonTapped});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          _NameTextFieldWidget(
              nameTextFieldText: nameTextFieldText,
              nameTextFieldChanged: nameTextFieldChanged),
          const SizedBox(height: 30),
          _NoteMainTextWidget(
              mainTextFieldText: mainTextFieldText,
              mainTextFieldChanged: mainTextFieldChanged),
          const SizedBox(height: 30),
          _DayRatingWidget(
            dayRatingTitle: dayRatingTitle,
            dayRatingValue: dayRatingValue, dropDownValueChanged: dropDownValueChanged,
          ),
          const SizedBox(height: 30),
          _ImagesWidget(pickGalleryButtonTapped: pickGalleryButtonTapped, 
          pickCameraButtonTapped: pickCameraButtonTapped)
        ])),
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Image.memory(
                  images[index],
                  height: getProportionateScreenHeight(context, 100),
                  width: getProportionateScreenWidth(context, 100),
                );
              },
              childCount: images.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ))
      ]),
    ));
  }
}

class _NameTextFieldWidget extends StatelessWidget {
  final String nameTextFieldText;
  final Function(String value) nameTextFieldChanged;

  const _NameTextFieldWidget(
      {super.key,
      required this.nameTextFieldText,
      required this.nameTextFieldChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController()..text = nameTextFieldText,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          labelText: "Title",
          helperText: "By default it will be set current date",
          border: OutlineInputBorder()),
      onChanged: nameTextFieldChanged,
    );
  }
}

class _NoteMainTextWidget extends StatelessWidget {
  final String mainTextFieldText;
  final Function(String value) mainTextFieldChanged;

  const _NoteMainTextWidget(
      {super.key,
      required this.mainTextFieldText,
      required this.mainTextFieldChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
    // keyboardType: TextInputType.done,
        textInputAction: TextInputAction.done,
        controller: TextEditingController(text: mainTextFieldText),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            hintText: "Write what you want here",
            border: OutlineInputBorder()),
        maxLines: null,
        minLines: null,
        onChanged: mainTextFieldChanged);
  }
}

class _DayRatingWidget extends StatelessWidget {
  final String dayRatingTitle;
  final String? dayRatingValue;
  final Function (String? value) dropDownValueChanged;

  const _DayRatingWidget(
      {super.key, required this.dayRatingTitle, required this.dayRatingValue, required this.dropDownValueChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(dayRatingTitle),
        const SizedBox(
          width: 30,
        ),
        DropdownButton<String>(
            value: dayRatingValue,
            items: dropDownButtonData
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: dropDownValueChanged,
            style: const TextStyle(color: Colors.blue)),
      ],
    );
  }
}

class _ImagesWidget extends StatelessWidget {

  final Future<dynamic>? Function (ImageSource source, BuildContext context) pickGalleryButtonTapped;
  final Future<dynamic>? Function (ImageSource source, BuildContext context) pickCameraButtonTapped;

  const _ImagesWidget({super.key, required this.pickGalleryButtonTapped, required this.pickCameraButtonTapped});

  @override
  Widget build(BuildContext context) {
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
                        await pickGalleryButtonTapped(
                            ImageSource.gallery, context),
                        child: const Text(
                          pickGallery,
                        )),
                    TextButton(
                        onPressed: () async => 
                        await pickCameraButtonTapped(ImageSource.camera, context),
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
