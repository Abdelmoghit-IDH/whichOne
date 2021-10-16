import 'package:azedpolls/models/gender_model.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  CustomRadio(this._gender);
  final Gender _gender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Card(
          elevation: 5,
          color: _gender.isSelected ? Color(0xFFdc8c97) : Colors.white,
          child: Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            margin: new EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _gender.icon,
                  color: _gender.isSelected ? Colors.white : Colors.grey,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  _gender.name,
                  style: TextStyle(
                      color: _gender.isSelected ? Colors.white : Colors.grey),
                )
              ],
            ),
          )),
    );
  }
}
