import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.onPressLeading,
    required this.onPressTrailing,
    required this.iconLeading,
    required this.iconTrailing,
    this.title,
    this.colorTilte,
    this.fontSizeTitle,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;
  final String? title;
  final IconData iconLeading, iconTrailing;
  final VoidCallback onPressLeading;
  final VoidCallback onPressTrailing;
  final Color? colorTilte;
  final double? fontSizeTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: onPressLeading,
        icon: Icon(
          // ignore: unnecessary_null_comparison
          iconLeading != null ? iconLeading : FontAwesomeIcons.arrowLeft,
          color: Colors.white,
          size: 25,
        ),
      ),
      actions: [
        // ignore: unnecessary_null_comparison
        if (iconTrailing != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: onPressTrailing,
              icon: Icon(
                iconTrailing,
                color: Colors.black,
              ),
            ),
          )
      ],
      title: Text(
        title!,
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: colorTilte ?? Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSizeTitle ?? 23,
        ),
      ),
    );
  }
}
