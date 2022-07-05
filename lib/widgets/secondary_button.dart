import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  final String text;
  final void Function() onPressed;

  const SecondaryButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).highlightColor,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
