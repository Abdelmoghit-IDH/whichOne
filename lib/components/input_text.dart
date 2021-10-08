import 'package:flutter/material.dart';
import '../const.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.visibility = false,
    this.keyboardType,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final bool? visibility;
  final TextInputType? keyboardType;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        obscureText: widget.visibility! ? !this._passwordVisible : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          hintText: widget.hintText,
          hintStyle: kHintTextStyle,
          suffixIcon: widget.visibility!
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: widget.visibility!
                      ? (_passwordVisible
                          ? Icon(
                              Icons.visibility,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ))
                      : Icon(null),
                )
              : null,
        ),
      ),
    );
  }
}
