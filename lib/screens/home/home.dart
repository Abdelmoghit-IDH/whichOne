import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.yellow),
  ];

  List<BottomNavigationBarItem> tabsItems = [
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.voteYea),
      label: "Vote",
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.plusCircle),
      label: "Create",
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.userCircle),
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
      appBar: AppBar(
        title: Text("WhichOne"),
        centerTitle: true,
        leading: Icon(null),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: tabsItems,
      ),
      body: tabs[currentTabIndex],
    );
  }
}
