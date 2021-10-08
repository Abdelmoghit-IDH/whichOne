import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_tabs/profile_tab.dart';
import 'home_tabs/vote_tab.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    VoteTab(),
    Container(color: Colors.red),
    ProfileTab(),
  ];

  List<BottomNavigationBarItem> tabsItems = [
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.voteYea,
      ),
      label: "Vote",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.plusCircle,
      ),
      label: "Create",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.userCircle,
      ),
      label: "Profile",
    ),
  ];

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFffd6da),
        selectedItemColor: Color(0xFFdc8c97),
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: tabsItems,
      ),
      body: SafeArea(child: tabs[currentTabIndex]),
    );
  }
}
