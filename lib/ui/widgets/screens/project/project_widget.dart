// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/ui/widgets/components/createTaskWidget.dart';
import 'package:todo_application/ui/widgets/screens/project/project_model.dart';

import '../../../../domain/constants.dart';
import '../../../../domain/data_providers/dark_theme_provider.dart';

class ProjectWidgetConfiguration {
  final int projectIndex;

  ProjectWidgetConfiguration({
    required this.projectIndex,
  });
}

//MARK: WIDGET

class ProjectWidget extends StatefulWidget {
  final ProjectWidgetConfiguration configuration;

  const ProjectWidget({super.key, required this.configuration});

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  late final ProjectViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = ProjectViewModel(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    return ProjectWidgetModelProvider(
        model: model, child: const _ProjectBody());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}

class _ProjectBody extends StatelessWidget {
  const _ProjectBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ProjectWidgetModelProvider.watch(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text(model?.project.name ?? "No name"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      bottomNavigationBar: const _BottomAppBarWidget(),
      floatingActionButton: const _BottomFloationActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // return ExpansionTile(
                //     title: const Text(color),
                //     expandedAlignment: Alignment.topLeft,
                //     children: model.colorWidgets);
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 20,
              //model?.project.categories.length
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            //model?.project.commonTasks.length.toDouble() ?? 0.0
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAppBarWidget extends StatelessWidget {
  const _BottomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return BottomAppBar(
      color: Colors.grey,
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.edit_note),
              color: themeState.darkTheme ? Colors.black : Colors.white,
              tooltip: openSettingsTooltip,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomFloationActionButton extends StatelessWidget {
  const _BottomFloationActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ProjectWidgetModelProvider.read(context)?.model;

    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        showModalBottomSheet<void>(
            isScrollControlled: true,
            isDismissible: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            backgroundColor: Colors.orange[300],
            context: context,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                  heightFactor: 0.9,
                  child: CreateTaskWidget(
                      priorityValue: priorityData.first,
                      dateController: model?.dateController ?? TextEditingController()
                  )
                );
            });
      },
      tooltip: createTaskTooltip,
      child: const Icon(Icons.add),
    );
  }
}
