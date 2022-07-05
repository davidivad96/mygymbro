import 'package:flutter/material.dart';

class BigText extends StatefulWidget {
  final String text;

  const BigText({Key? key, required this.text}) : super(key: key);

  @override
  State<BigText> createState() => _BigTextState();
}

class _BigTextState extends State<BigText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
