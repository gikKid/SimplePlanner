import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/data_providers/dark_theme_provider.dart';

//MARK: VIEW MODEL
class _ViewModel extends ChangeNotifier {}

//MARK: WIDGET

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => _ViewModel(), child: const SettingsWidget());
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text(accountTitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.mail_rounded),
                title: const Text(supportTitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.light_mode_outlined),
                title: const Text(darkThemeTitle),
                trailing: Switch(
                    value: themeState.darkTheme,
                    onChanged: (bool value) {
                      themeState.darkTheme = value;
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
