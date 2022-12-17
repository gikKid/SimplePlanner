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
      ),
      body: GridView.builder(
          shrinkWrap: true,
          itemCount: model.notes.length + 1,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Center(
                child: TextButton(
                  child: const Text(createNoteTooltip),
                  onPressed: () => model.userTapCreateNoteButton(context),
                ),
              );
            }
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.orange[300]),
              child: Text(model.notes[index - 1].name),
            );
          }),
    );
  }
}
