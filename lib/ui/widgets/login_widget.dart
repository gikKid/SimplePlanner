import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';

enum _ViewModelAuthButtonState { canConfirm, authProcess, disable }

//MARK: ViewModelState

class _ViewModelState {
  String authErrorTitle = '';
  String login = '';
  String password = '';
  bool isAuthInProcess = false;

  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcess;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return _ViewModelAuthButtonState.canConfirm;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }
}

//MARK: ViewModel

class _ViewModel extends ChangeNotifier {
  final _state = _ViewModelState();
  _ViewModelState get state => _state;

  void changeLogin(String value) {
    if (_state.login == value) return;
    _state.login = value;
    notifyListeners();
  }

  void changePassword(String value) {
    if (_state.password == value) return;
    _state.password = value;
    notifyListeners();
  }
}

//MARK: LoginWidget

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => _ViewModel(), child: const LoginWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _ErrorTitleWidget(),
              SizedBox(height: 10),
              _LoginTextFieldWidget(),
              SizedBox(height: 10),
              _PasswordTextField(),
              SizedBox(height: 10),
              _ConfirmButtonWidget(),
            ],
          ))),
    );
  }
}

class _ErrorTitleWidget extends StatelessWidget {
  const _ErrorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authErrorTitle =
        context.select((_ViewModel value) => value.state.authErrorTitle);

    return Text(authErrorTitle);
  }
}

class _LoginTextFieldWidget extends StatelessWidget {
  const _LoginTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(labelText: loginTitle),
      onChanged: model.changeLogin,
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(labelText: passwordTitle),
      obscureText: true,
      onChanged: model.changePassword,
    );
  }
}

class _ConfirmButtonWidget extends StatelessWidget {
  const _ConfirmButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("confirm"),
    );
  }
}
