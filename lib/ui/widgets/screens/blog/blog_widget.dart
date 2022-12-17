import 'package:flutter/material.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/widgets/screens/blog/blog.model.dart';

//MARK: WIDGET

class BlogWidget extends StatefulWidget {
  const BlogWidget({super.key});

  @override
  State<BlogWidget> createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {
  final _model = BlogViewModel();

  @override
  Widget build(BuildContext context) {
    return BlogWidgetModelProvider(
        model: _model, child: const _BlogWidgetBody());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}

class _BlogWidgetBody extends StatelessWidget {
  const _BlogWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = BlogWidgetModelProvider.watch(context)!.model;

    return Scaffold(
      appBar: AppBar(
        title: const Text(myBlogTitle),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: <Widget>[
              if (model.isSelectionMode) IconButton(
              onPressed: () => model.selectedNotes.isEmpty ? null : model.userTapDeleteNotes(), 
              icon: const Icon(Icons.delete_outline),
              color: model.selectedNotes.isEmpty ? Colors.grey: Colors.red),
              TextButton(
              onPressed: () => model.isSelectionMode ? model.userTapCancelButton() : model.userTapSelectButton(),
              child: Text(
                model.isSelectionMode ? cancel : select,
              ))
        ],
      ),
      body: GridView.builder(
          shrinkWrap: true,
          itemCount: model.notes.length + 1,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Center(
                child: TextButton(
                  child: const Text(
                    createNoteTooltip,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () => model.userTapCreateNoteButton(context),
                ),
              );
            }
            return InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: model.selectedNotes.contains(index) ? Colors.blue : Colors.orange[300]),
                child: Text(model.notes[index - 1].name),
              ),
              onTap: () => model.userSelectNote(index),
            );
          }),
    );
  }
}
