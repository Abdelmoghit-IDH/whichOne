import 'dart:io';
import 'package:flutter/material.dart';
import 'add_image.dart';

class PicturePoll extends StatelessWidget {
  const PicturePoll({
    Key? key,
    this.imageFile1,
    this.imageFile2,
    this.onPressed1,
    this.onPressed2,
  }) : super(key: key);

  final File? imageFile1;
  final File? imageFile2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        AddImage(
          index: 1,
          imageFile: imageFile1,
          onPressed: onPressed1,
        ),
        SizedBox(height: 10),
        AddImage(
          index: 2,
          imageFile: imageFile2,
          onPressed: onPressed2,
        ),
      ],
    );
  }
}
