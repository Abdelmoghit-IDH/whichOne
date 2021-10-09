import 'package:flutter/material.dart';
import 'package:azedpolls/components/custom_appbar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        iconLeading: IconData(2),
        iconTrailing: IconData(2),
        onPressLeading: () {},
        onPressTrailing: () {},
        title: 'Someone',
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFffd6da),
                  Color(0xFFfccfd2),
                  Color(0xFFfdbec6),
                  Color(0xFFdc8c97),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          BodyProfile(),
        ],
      ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
