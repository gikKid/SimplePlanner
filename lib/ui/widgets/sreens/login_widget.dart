import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/size_config.dart';
import 'package:todo_application/ui/widgets/components/commonTextFormField.dart';
import 'package:todo_application/ui/widgets/components/continueButton.dart';
import 'package:todo_application/ui/widgets/components/errorForm.dart';

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
        appBar: AppBar(
          title: const Text(loginTitleButton),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(context, 20)),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                SizedBox(height:SizeConfig(mediaQueryData: MediaQuery.of(context)).screenHeight() * 0.25,),
               const SignForm()],
              ),
            ),
          ),
        ))
        );
  }
}

class SignForm extends StatelessWidget {
  const SignForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return Form(
        child: Column(
      children: [
        CommonTextFormField(
          labelTitle: "Username",
          hintTitle: "Write your username",
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          press: ((value) {
            model.changeLogin(value);
          }),
        ),
        const SizedBox(height: 20),
        CommonTextFormField(
          labelTitle: "Password",
          hintTitle: "Write your password",
          icon: Icons.lock_outline,
          keyboardType: TextInputType.text,
          obscureText: true,
          press: ((value) {
            model.changePassword(value);
          }),
        ),
        SizedBox(
          height: getProportionateScreenHeight(context, 20),
        ),
        const _ErrorRowWidget(),
        ContinueButton(
        text: "Continue", 
        press: () {}, 
        backColor: model.state.login.isNotEmpty & model.state.password.isNotEmpty ? Colors.orange : Colors.grey)
      ],
    ));
  }
}

class _ErrorRowWidget extends StatelessWidget {
  const _ErrorRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
  final errorTitle = context.select((_ViewModel value) => value.state.authErrorTitle);
    return ErrorForm(text: errorTitle);
  }
}
