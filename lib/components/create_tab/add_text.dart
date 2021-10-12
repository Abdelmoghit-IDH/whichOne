import 'package:flutter/material.dart';

class AddText extends StatelessWidget {
  const AddText({
    Key? key,
    this.index,
    this.onPressed,
    this.controller,
  }) : super(key: key);

  final int? index;
  final VoidCallback? onPressed;
  final TextEditingController? controller;

  rightOption(int index) {
    if (index == 1)
      return 'One';
    else
      return 'Two';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          child: Image.asset(
            'assets/images/poll$index.png',
            fit: BoxFit.cover,
          ),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 300,
            child: Center(
              child: TextField(
                controller: controller,
                maxLines: 2,
                textAlign: TextAlign.center,
                cursorHeight: 40,
                cursorColor: Color(0xFFdc8c97),
                style: TextStyle(
                  fontSize: 25.0,
                  height: 1.5,
                  color: Color(0xFFdc8c97),
                ),
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: "Tap to Type Option ${rightOption(index!)}",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFfccfd2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
