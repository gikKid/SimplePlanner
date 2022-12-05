import 'package:flutter/material.dart';
import '../../../domain/size_config.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.text,
    required this.press, required this.backColor,
  }) : super(key: key);

  final String text;
  final Function() press;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(context, 56),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(context, 18),
              color: Colors.white),
        ),
      ),
    );
  }
}
