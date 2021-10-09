import 'dart:io';

import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  const AddImage({
    Key? key,
    this.index,
    this.onPressed,
    this.imageFile,
  }) : super(key: key);

  final int? index;
  final VoidCallback? onPressed;
  final File? imageFile;

  rightOption(int index) {
    if (index == 1)
      return 'One';
    else
      return 'Two';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/poll$index.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: new BoxDecoration(
                        color: Color(0xFFdc8c97),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                          color: Color(0xFFffd6da),
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Option ${rightOption(index!)}',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFdc8c97),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (imageFile != null)
              Container(
                height: 300,
                width: double.infinity,
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
