import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';

//MARK: ViewModel

class _ViewModel {

}

//MARK: MainWidget

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  static Widget create() {
    return Provider(create: (_) => _ViewModel(), child: const MainWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    

    );
  }
}