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

  final textFieldborder = OutlineInputBorder(borderRadius: BorderRadius.circular(5));

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
    appBar: AppBar(title: const Text(loginTitleButton),centerTitle: true,backgroundColor: Colors.orange,),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _ErrorTitleWidget(),
              SizedBox(height: 10),
              _LoginTextFieldWidget(),
              SizedBox(height: 15),
              _PasswordTextField(),
              SizedBox(height: 10),
              _ConfirmButtonWidget(),
            ],
          )
        )
      ),
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
      decoration: InputDecoration(labelText: loginTitle,
      border: model.textFieldborder),
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
      decoration: InputDecoration(labelText: passwordTitle,
      border: model.textFieldborder),
      obscureText: true,
      onChanged: model.changePassword,
    );
  }
}

class _ConfirmButtonWidget extends StatelessWidget { //FUTURE: Create reusable confirm buttons
  const _ConfirmButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.all(10),
      fixedSize: const Size(200, 50),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      ),
      onPressed: () {},
      child: const Text(confirmTitle),
    );
  }
}
