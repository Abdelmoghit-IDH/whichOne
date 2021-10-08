import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTab extends StatelessWidget {
  const CreateTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                  left: 15,
                  right: 15,
                ),
                child: Text(
                  "Would you rather speak to animals or know other people's thouts?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.red,
                height: 300,
              ),
              SizedBox(height: 3),
              Container(
                width: double.infinity,
                color: Colors.green,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 35,
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        "newunicorngirl",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Follow",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "2 Days ago",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.ellipsisH,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  height: 2,
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.black,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "4 Votes",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
