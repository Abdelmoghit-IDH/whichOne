import 'package:flutter/material.dart';

import 'add_text.dart';

class TextPoll extends StatelessWidget {
  const TextPoll({
    Key? key,
    this.onPressed1,
    this.onPressed2,
    this.optionOneController,
    this.optionTwoController,
  }) : super(key: key);

  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  final TextEditingController? optionOneController;
  final TextEditingController? optionTwoController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        AddText(
          index: 1,
          controller: optionOneController,
          onPressed: onPressed1,
        ),
        SizedBox(height: 10),
        AddText(
          index: 2,
          controller: optionTwoController,
          onPressed: onPressed2,
        ),
      ],
    );
  }
}
