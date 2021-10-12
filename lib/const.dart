import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 17,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xffdc8c97),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

List<BottomNavigationBarItem> tabsItems = [
  BottomNavigationBarItem(
    icon: Icon(
      FontAwesomeIcons.fileImage,
    ),
    label: "Picture",
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.format_size,
    ),
    label: "Text",
  ),
];
