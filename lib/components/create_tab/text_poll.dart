import 'package:flutter/material.dart';

import 'add_text.dart';

class TextPoll extends StatelessWidget {
  const TextPoll({
    Key? key,
    this.onPressed1,
    this.onPressed2,
  }) : super(key: key);

  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        AddText(
          index: 1,
          onPressed: onPressed1,
        ),
        SizedBox(height: 10),
        AddText(
          index: 2,
          onPressed: onPressed2,
        ),
      ],
    );
  }
}
