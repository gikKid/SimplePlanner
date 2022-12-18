import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/ui/widgets/components/noteBody.dart';
import 'package:todo_application/ui/widgets/screens/note/note_model.dart';

import '../../../../domain/constants.dart';

class NoteWidgetConfiguration {
  final int noteIndex;

  NoteWidgetConfiguration({
    required this.noteIndex,
  });
}

//MARK: - WIDGET

class NoteWidget extends StatefulWidget {
  final NoteWidgetConfiguration configuration;

  const NoteWidget({super.key, required this.configuration});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  late final NoteViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = NoteViewModel(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    return NoteWidgetModelProvider(
        model: model, child: const _NoteWidgetBody());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}

class _NoteWidgetBody extends StatelessWidget {
  const _NoteWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NoteWidgetModelProvider.watch(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text(model?.note.name ?? "No name"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: NoteBody(
          images: model?.note.images ?? [Uint8List(0)],
          nameTextFieldText: model?.note.name ?? "no name",
          nameTextFieldChanged: ((value) {
            model?.note.name = value;
          }),
          mainTextFieldText: model?.note.mainText ?? "no text",
          mainTextFieldChanged: ((value) {
            model?.note.mainText = value;
          }),
          dayRatingTitle: dayRatingTitle,
          dayRatingValue: model?.dayRatingValue,
          dropDownValueChanged: ((value) {
            model?.dayRatingValueChanged(value);
          }),
          pickGalleryButtonTapped: ((imageSource, context) {
            model?.pickImageButtonTapped(imageSource, context);
            return null;
          }),
          pickCameraButtonTapped: ((imageSource, context) {
            model?.pickImageButtonTapped(imageSource, context);
            return null;
          })),
    );
  }
}
