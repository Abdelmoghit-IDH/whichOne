import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    this.height = 50.0,
    this.width = 50.0,
    this.value,
    Key? key,
  }) : super(key: key);
  final double? value;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: Color(0xFFdc8c97),
        value: value,
      ),
    );
  }
}
