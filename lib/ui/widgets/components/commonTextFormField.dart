import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String value) press;

  CommonTextFormField(
      {super.key, required this.labelTitle, required this.hintTitle, required this.icon, required this.keyboardType, required this.obscureText, required this.press});

  final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: Color.fromARGB(255, 119, 118, 118)),
      gapPadding: 10);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    keyboardType: keyboardType,
    obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelTitle,
          hintText: hintTitle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          suffixIcon: Icon(icon)),
          onChanged: press,
    );
  }
}
