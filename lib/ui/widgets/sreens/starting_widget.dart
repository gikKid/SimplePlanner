import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/navigation/main_navigation.dart';

//MARK: VIEWMODEL

class _ViewModel {
  static double buttonWidth = 150;
  static double buttonHeight = 50;

  BuildContext context;

  final startingButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.all(10),
      fixedSize: Size(buttonWidth, buttonHeight),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      shape: const StadiumBorder());

  final sharedPreferences = SharedPreferences.getInstance();

  _ViewModel(this.context) {
    didLoad();
  }

  void onLoginButtonPressed(BuildContext context) {
    MainNavigation.showLoginScreen(context);
  }

  void onRegisterButtonPressed(BuildContext context) {
    MainNavigation.showRegisterScreen(context);
  }

  Future<void> didLoad() async {
    final isEntered = (await sharedPreferences).getBool(isEnteredKey);
    if (isEntered != null && isEntered) {
      MainNavigation.showMainScreen(context);
    }
  }

  Future<void> onSkipLoginButtonPressed() async {
    (await sharedPreferences).setBool(isEnteredKey, true);
    MainNavigation.showMainScreen(context);
  }
}

//MARK: WIDGET

class StartingWidget extends StatelessWidget {
  const StartingWidget({super.key});

  static Widget create() {
    return Provider(create: (context) => _ViewModel(context), child: const StartingWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _LoginButtonWidget(),
              SizedBox(height: 30),
              _RegisterButtonWidget(),
              SizedBox(height: 10),
              _SkipLoginButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget { //FUTURE: Create reusable starting buttons
  const _LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return ElevatedButton(
        onPressed: () => model.onLoginButtonPressed(context),
        style: model.startingButtonStyle,
        child: const Text(loginTitleButton));
  }
}

class _RegisterButtonWidget extends StatelessWidget {
  const _RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return ElevatedButton(
        onPressed: () => model.onRegisterButtonPressed(context),
        style: model.startingButtonStyle,
        child: const Text(registerTitleButton));
  }
}

class _SkipLoginButton extends StatelessWidget {
  const _SkipLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextButton(
        onPressed: () => model.onSkipLoginButtonPressed.call(),
        child: const Text(
          skipButtonTitle,
          style: TextStyle(color: Colors.grey),
        ));
  }
}
