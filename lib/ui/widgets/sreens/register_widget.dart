import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/domain/constants.dart';

//MARK: ViewModel

class _ViewModel extends ChangeNotifier {}

//MARK: RegisterWidget

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => _ViewModel(), child: const RegisterWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(registerTitleButton),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _ErrorTitleWidget(),
            SizedBox(height: 10),
            _UsernameWidget(),
            SizedBox(height: 10),
            _EmailWidget(),
            SizedBox(height: 10),
            _PasswordWidget(),
            SizedBox(height: 10),
            _ConfirmPasswordWidget(),
            SizedBox(height: 20),
            _ConfirmButtonWidget()
          ],
        ),
      ),
    );
  }
}

class _ErrorTitleWidget extends StatelessWidget {
  const _ErrorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _UsernameWidget extends StatelessWidget { // FUTURE: Create reusable register rows
  const _UsernameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            "$usernameTitle:",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 10),
          Expanded(child: TextField(
            decoration: InputDecoration(
                labelText: usernameTitle, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onChanged: (value) {},
          )),
        ],
      ),
    );
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            "$emailTitle:",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 10),
          Expanded(child: TextField(
            decoration: InputDecoration(
                labelText: emailTitle, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onChanged: (value) {},
          )),
        ],
      ),
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            "$passwordTitle:",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 10),
          Expanded(child: TextField(
            decoration: InputDecoration(
                labelText: passwordTitle, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onChanged: (value) {},
          )),
        ],
      ),
    );
  }
}

class _ConfirmPasswordWidget extends StatelessWidget {
  const _ConfirmPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            "$confirmPasswordTitle:",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 10),
          Expanded(child: TextField(
            decoration: InputDecoration(
                labelText: passwordTitle, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onChanged: (value) {},
          )),
        ],
      ),
    );
  }
}

class _ConfirmButtonWidget extends StatelessWidget {
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