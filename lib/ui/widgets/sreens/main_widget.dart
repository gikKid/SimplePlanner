import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/navigation/main_navigation.dart';

import '../../../domain/data_providers/dark_theme_provider.dart';

//MARK: VIEW MODEL

class _ViewModel extends ChangeNotifier {
  void userTapSettingsButton(BuildContext context) {
    MainNavigation.showSettingsScreen(context);
  }

  void userTapBlogButton(BuildContext context) {
    MainNavigation.showBlogScreen(context);
  }
}

//MARK: WIDGET

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => _ViewModel(), child: const MainWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      drawer: const _DrawerWidget(),
      bottomNavigationBar: const _BottomAppBarWidget(),
      floatingActionButton: const _FloatingActionButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                menuTitle,
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text(calendarTitle),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.line_axis_outlined),
            title: const Text(productivity),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text(incomingTitle),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text(myBlogTitle),
            onTap: () => model.userTapBlogButton(context),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(favoriteTitle),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.folder_copy_sharp),
            title: const Text(projectsTitle),
            onTap: () {},
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
    final model = context.read<_ViewModel>();
    final themeState = Provider.of<DarkThemeProvider>(context);

    return BottomAppBar(
      color: Colors.grey,
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              onPressed: () => model.userTapSettingsButton(context),
              icon: const Icon(Icons.settings),
              color: themeState.darkTheme ? Colors.black : Colors.white,
              tooltip: openSettingsTooltip,
            )
          ],
        ),
      ),
    );
  }
}

class _FloatingActionButtonWidget extends StatelessWidget {
  const _FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {},
      tooltip: createTaskTooltip,
      child: const Icon(Icons.add),
    );
  }
}
