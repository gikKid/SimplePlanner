import 'package:flutter/material.dart';
import 'package:todo_application/domain/size_config.dart';

class ErrorForm extends StatelessWidget {
  final String text;

  const ErrorForm({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
    // const Icon(Icons.error_outline,color: Colors.red,),
    // SizedBox(width: getProportionateScreenWidth(context, 20),),
    Expanded(child: Text(text,style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w300,fontSize: 12),))
    ],
    );
  }
}
