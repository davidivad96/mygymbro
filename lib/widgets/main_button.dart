import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final String text;
  final void Function() onPressed;

  const MainButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        //minimumSize: const Size(50.0, 30.0),
        primary: Theme.of(context).primaryColor,
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
