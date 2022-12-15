import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {}

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
    return Scaffold(
    appBar: AppBar(title: const Text(myBlogTitle),backgroundColor: Colors.orange,centerTitle: true,),
    bottomNavigationBar: const BottomAppBar(
    
    ),
    );
  }
}
