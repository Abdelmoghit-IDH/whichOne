import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    Key? key,
    @required this.text,
    @required this.onPressed,
    this.color,
    this.borderRadius = 30,
    this.icon,
    this.textColor,
    this.sizeIcon,
    this.fontSize,
    this.iconColor,
    this.boxBorder,
  });

  final Color? color;
  final Color? textColor;
  final String? text;
  final double? borderRadius;
  final Function? onPressed;
  final IconData? icon;
  final double? sizeIcon;
  final Color? iconColor;
  final double? fontSize;
  final BoxBorder? boxBorder;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void _onTapDown(TapDownDetails details) {
    _controller!.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller!.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      onTap: widget.onPressed!(),
      child: Transform.scale(
        scale: _scale!,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: Offset(0, 6),
                  blurRadius: 8)
            ],
            border: widget.boxBorder,
          ),
          constraints: BoxConstraints(
            maxWidth: 230,
            minHeight: 58,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.text!,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                    ),
              ),
              // ignore: unnecessary_null_comparison
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  // ignore: unnecessary_null_comparison
                  color: widget.iconColor != null
                      ? widget.iconColor
                      : Theme.of(context).primaryColor,
                  size: widget.sizeIcon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
