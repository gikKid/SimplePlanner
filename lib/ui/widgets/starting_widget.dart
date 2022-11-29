import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/navigation/main_navigation.dart';

class _ViewModel {

  void onLoginButtonPressed(BuildContext context) {
    MainNavigation.showLoginScreen(context);
  }

  void onRegisterButtonPressed(BuildContext context) {
    MainNavigation.showRegisterScreen(context);
  }
}

class StartingWidget extends StatelessWidget {
  const StartingWidget({super.key});

  static Widget create() {
    return Provider(
        create: (_) => _ViewModel(), child: const StartingWidget());
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
              SizedBox(height: 10),
              _RegisterButtonWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return OutlinedButton(onPressed: () => model.onLoginButtonPressed(context), 
    child: const Text(loginTitleButton,style: TextStyle(color: Colors.orange))
    );
  }
}

class _RegisterButtonWidget extends StatelessWidget {
  const _RegisterButtonWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return OutlinedButton(onPressed: () => model.onRegisterButtonPressed(context), 
    child: const Text(registerTitleButton,style: TextStyle(color: Colors.orange))
    );
  }
}
