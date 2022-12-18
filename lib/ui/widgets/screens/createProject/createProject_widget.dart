import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/HexColor.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/data_providers/box_manager.dart';
import 'package:todo_application/domain/size_config.dart';

import '../../../../entity/project.dart';

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {
  List<Widget> colorWidgets = [];
  String selectedColor = colorsData.first.hex;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  String projectName = "";
  bool isValidName = false;

  _ViewModel() {
    _configureColorsWidget();
  }

  void changeName(String value) {
    if (value == incomingTitle 
    || value == incomingTitle.toLowerCase() 
    || value == incomingTitle.toUpperCase()
    || value.trim() == "") {
      isValidName = false;
    } else {
      projectName = value;
      isValidName = true;
    }
    notifyListeners();
  }

  void userTapCreateProject(BuildContext context) async {
    final project = Project(
        name: projectName,
        isFavorite: isFavorite,
        hexColor: selectedColor,
        categories: [],
        commonTasks: []);

    final box = await BoxManager.shared.openProjectsBox();
    await box.add(project);
    await BoxManager.shared.closeBox(box);
    Navigator.of(context).pop();
  }

  void _configureColorsWidget() {
    for (var colorData in colorsData) {
      final inkWell = InkWell(
        child: Row(
          children: [
            Icon(Icons.circle, color: HexColor(colorData.hex)),
            Text(colorData.name)
          ],
        ),
        onTap: () {
          selectedColor = colorData.hex;
          notifyListeners();
        },
      );
      colorWidgets.add(inkWell);
    }
  }
}

//MARK: WIDGET

class CreateProjectWidget extends StatelessWidget {
  const CreateProjectWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const CreateProjectWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(createProject),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(context, 20)),
                child: SingleChildScrollView(
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(children: const <Widget>[
                          SizedBox(height: 30),
                          _NameTextFieldWidget(),
                          SizedBox(height: 30),
                          _ColorsWidget(),
                          SizedBox(height: 30),
                          _IsFavoriteRowWidget()
                        ]))))),
        floatingActionButton: model.isValidName
            ? FloatingActionButton(
                tooltip: done,
                backgroundColor: Colors.orange,
                child: const Icon(Icons.done),
                onPressed: () => model.userTapCreateProject(context))
            : null);
  }
}

class _NameTextFieldWidget extends StatelessWidget {
  const _NameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          labelText: "Name",
          errorText: model.isValidName || model.projectName == ""
              ? null
              : "You cant create project with this name",
          border: const OutlineInputBorder()),
      onChanged: (value) => model.changeName(value),
    );
  }
}

class _ColorsWidget extends StatelessWidget {
  const _ColorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return ExpansionTile(
        title: const Text(color),
        leading: Icon(Icons.circle, color: HexColor(model.selectedColor)),
        expandedAlignment: Alignment.topLeft,
        children: model.colorWidgets);
  }
}

class _IsFavoriteRowWidget extends StatelessWidget {
  const _IsFavoriteRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return Row(
      children: [
        const Icon(Icons.favorite),
        const SizedBox(width: 30),
        const Text(favoriteTitle),
        const Spacer(),
        Switch(
            value: model.isFavorite,
            onChanged: (value) => model.isFavorite = value)
      ],
    );
  }
}
