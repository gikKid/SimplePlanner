import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/navigation/main_navigation.dart';

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {
  void userTapCreateNoteButton(BuildContext context) {
    MainNavigation.showCreateNoteScreen(context);
  }
}

//MARK: WIDGET

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const BlogWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(myBlogTitle),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => model.userTapCreateNoteButton(context),
        tooltip: createNoteTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
