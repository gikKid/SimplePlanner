import 'package:flutter/material.dart';
import 'package:todo_application/domain/HexColor.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/widgets/screens/projects/projects_model.dart';

//MARK: WIDGET

class ProjectsWidget extends StatefulWidget {
  const ProjectsWidget({super.key});

  @override
  State<ProjectsWidget> createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {

  @override
  Widget build(BuildContext context) {
    return ProjectsWidgetModelProvider(
        model: ProjectsViewModel(), child: const _ProjectsBody());
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _ProjectsBody extends StatelessWidget {
  const _ProjectsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ProjectsWidgetModelProvider.watch(context)!.model;

    return Scaffold(
      appBar: AppBar(
        title: const Text(projectsTitle),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: <Widget>[
          if (model.selectedKeys.isNotEmpty) IconButton(
              onPressed: () => model.userTapDeleteProjects(),
              icon: const Icon(Icons.delete_outline),
              color: model.selectedKeys.isNotEmpty ? Colors.red : Colors.grey) ,
          if (model.isSelectionMode)
            TextButton(
                onPressed: () => model.userTapSelectAll(),
                child: Text(model.selectAll ? deselectAll : selectAll)),
          TextButton(
              onPressed: () => model.isSelectionMode
                  ? model.userTapCancelButton()
                  : model.userTapSelectButton(),
              child: Text(model.isSelectionMode ? cancel : select))
        ],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: model.projects.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Center(
                  child: TextButton(
                child: const Text(
                  createProject,
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () => model.userTapCreateProject(context),
              ));
            } else {
              return InkWell(
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: model.selectedProjects.contains(index)
                            ? Colors.blue
                            : Colors.orange[300]),
                    child: Row(
                      children: [
                        Icon(Icons.circle,
                            color:
                                HexColor(model.projects[index - 1].hexColor)),
                        const SizedBox(width: 40),
                        Text(model.projects[index - 1].name)
                      ],
                    )),
                onTap: () => model.userSelectProject(context, index),
              );
            }
          }),
    );
  }
}
