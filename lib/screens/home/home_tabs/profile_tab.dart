import 'dart:math';
import 'package:azedpolls/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BodyProfile(),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff414141),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(authNotifier.user.coverUrl!),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                        trailing: IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/Settings'),
                      icon: Icon(
                        FontAwesomeIcons.cog,
                        color: Colors.white,
                      ),
                    )),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 45,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                    ),
                    Text(
                      authNotifier.user.username!,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/EditProfile'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff414141),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff414141),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            "Friend Feed",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "1 AzedPoll",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "1 Follower",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "1 Following",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.white,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: TabBar(
                              labelColor: Colors.black,
                              indicatorColor: Colors.black,
                              labelStyle: TextStyle(
                                fontSize: 19,
                              ),
                              tabs: [
                                Tab(text: "Activity"),
                                Tab(text: "Polls"),
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          //height: 400,
                          child: TabBarView(children: [
                            Container(
                              child: Text("Home Body"),
                            ),
                            Container(
                              child: GridView.extent(
                                childAspectRatio: (2 / 2),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                padding: EdgeInsets.all(10.0),
                                maxCrossAxisExtent: 200.0,
                                children: List.generate(50, (index) {
                                  return Container(
                                    padding: EdgeInsets.all(20.0),
                                    child: Center(
                                      child: GridTile(
                                        footer: Text(
                                          'Item $index',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        child: Icon(Icons.access_alarm,
                                            size: 40.0, color: Colors.white),
                                      ),
                                    ),
                                    color: RandomColorModel().getColor(),
                                    margin: EdgeInsets.all(1.0),
                                  );
                                }),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//TODO: to delete

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}
