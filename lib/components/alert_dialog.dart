import 'dart:io';
import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String? title;
  final String? description;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;

  const Alert({
    Key? key,
    this.title,
    this.description,
    this.onYesPressed,
    this.onNoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          fontSize: 16,
        ),
      ),
      content: Text(
        'Are you sure ?',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
          fontSize: 16,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onNoPressed ?? () => Navigator.of(context).pop(false),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: Text("No"),
        ),
        ElevatedButton(
          onPressed: onYesPressed ?? () => exit(0),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: Text("Yes"),
        ),
      ],
    );
  }
}
