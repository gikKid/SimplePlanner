import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/size_config.dart';
import 'package:todo_application/ui/widgets/components/commonTextFormField.dart';
import 'package:todo_application/ui/widgets/components/errorForm.dart';

import '../components/continueButton.dart';

enum _ViewModelAuthButtonState { canConfirm, authProcess, disable }

//MARK: VIEW MODEL STATE

class _ViewModelState {
  String authErrorTitle = '';
  String username = '';
  String mail = '';
  String password = '';
  bool isValidatePasswords = false;
  bool isAuthInProcess = false;

  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcess;
    } else if (username.isNotEmpty &&
        mail.isNotEmpty &&
        password.isNotEmpty &&
        isValidatePasswords) {
      return _ViewModelAuthButtonState.canConfirm;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }
}

//MARK: VIEWMODEL

class _ViewModel extends ChangeNotifier {
  final _state = _ViewModelState();
  _ViewModelState get state => _state;

  void changeUsername(String value) { //FIXING: Make generic changing function
    if (value.isEmpty) {
      _state.authErrorTitle = emptyUsernameError;
      notifyListeners();
      return;
    } else if (value.length <= 5) {
      _state.authErrorTitle = lengthUsernameError;
      notifyListeners();
      return;
    } else {
      _state.username = value;
      _state.authErrorTitle = "";
      notifyListeners();
    }
  }

  void changeMail(String value) {
    if (value.isEmpty) {
      _state.authErrorTitle = emptyMailError;
      notifyListeners();
      return;
    } else if (!_checkValidMail(value)) {
      _state.authErrorTitle = validationMailError;
      notifyListeners();
      return;
    } else {
      _state.mail = value;
      _state.authErrorTitle = "";
      notifyListeners();
    }
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      _state.authErrorTitle = emptyPasswordError;
      notifyListeners();
      return;
    } else if (!_checkValidPassword(value)) {
      _state.authErrorTitle = validationPasswordError;
      notifyListeners();
      return;
    } else {
      _state.password = value;
      _state.authErrorTitle = "";
      notifyListeners();
    }
  }

  void changeConfirmPassword(String value) {
    if (value.isEmpty) {
      _state.authErrorTitle = emptyPasswordError;
      notifyListeners();
      return;
    } else if (_state.password != value) {
      _state.authErrorTitle = matchingPasswordError;
      notifyListeners();
      return;
    } else {
      _state.isValidatePasswords = true;
      _state.authErrorTitle = "";
      notifyListeners();
    }
  }

  bool _checkValidMail(String mail) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(mail);

  bool _checkValidPassword(String password) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\&*~]).{8,}$')
          .hasMatch(password);
}

//MARK: WIDGET

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => _ViewModel(), child: const RegisterWidget());
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(registerTitleButton),
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
                  SizedBox(
                      height: SizeConfig(mediaQueryData: MediaQuery.of(context))
                              .screenHeight() *
                          0.08),
                  const _ErrorTitleWidget(),
                  const SizedBox(height: 10),
                  const _UsernameWidget(),
                  const SizedBox(height: 25),
                  const _MailWidget(),
                  const SizedBox(height: 25),
                  const _PasswordWidget(),
                  const SizedBox(height: 25),
                  const _ConfirmPasswordWidget(),
                  const SizedBox(height: 30),
                  ContinueButton(
                      text: confirmTitle,
                      press: () {},
                      backColor: model._state.authButtonState ==
                              _ViewModelAuthButtonState.canConfirm
                          ? Colors.orange
                          : Colors.grey)
                ],
              ),
            ),
          ),
        )));
  }
}

class _ErrorTitleWidget extends StatelessWidget {
  const _ErrorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final title =
        context.select((_ViewModel value) => value.state.authErrorTitle);

    return ErrorForm(
      text: title,
    );
  }
}

class _UsernameWidget extends StatelessWidget {
  const _UsernameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    return CommonTextFormField(
      labelTitle: usernameTitle,
      hintTitle: usernamePlaceholder,
      icon: Icons.person_outline,
      keyboardType: TextInputType.text,
      obscureText: false,
      press: (value) {
        model.changeUsername(value);
      },
    );
  }
}

class _MailWidget extends StatelessWidget {
  const _MailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return CommonTextFormField(
      labelTitle: emailTitle,
      hintTitle: emailPlaceholder,
      icon: Icons.mail_outlined,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      press: (value) {
        model.changeMail(value);
      },
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return CommonTextFormField(
      labelTitle: passwordTitle,
      hintTitle: passwordPlaceholder,
      icon: Icons.lock_outline,
      keyboardType: TextInputType.text,
      obscureText: true,
      press: (value) {
        model.changePassword(value);
      },
    );
  }
}

class _ConfirmPasswordWidget extends StatelessWidget {
  const _ConfirmPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return CommonTextFormField(
      labelTitle: confirmPasswordTitle,
      hintTitle: confirmPasswordPlaceholder,
      icon: Icons.lock_outline,
      keyboardType: TextInputType.text,
      obscureText: true,
      press: (value) {
        model.changeConfirmPassword(value);
      },
    );
  }
}
