import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

chooseImage(BuildContext context,ImagePicker picker) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: new Text(
                'Select an Option',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: new Text(
                'Take Photo',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: new Text(
                'Choose from Gallery',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: new Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
