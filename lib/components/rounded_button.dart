import 'package:covid19_app/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Function press;
  final Color color, textColor;
  final Size size;
  final double borderRadiusSize;
  final EdgeInsets padding;
  const RoundedButton(
      {Key key,
      this.text,
      this.textAlign,
      this.press,
      this.color = mainColor,
      this.textColor = Colors.white,
      this.size = const Size(0, 0),
      this.borderRadiusSize = 30,
      this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 40)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size == null || size.width == 0)
          ? MediaQuery.of(context).size.width * 0.8
          : size.width,
      height: (size == null || size.height == 0) ? null : size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusSize),
        child: FlatButton(
          padding: padding,
          color: color,
          onPressed: press,
          child: Text(
            text,
            textAlign: textAlign,
            style: TextStyle(
              color: textColor,
              fontSize: 14
            ),
          ),
        ),
      ),
    );
  }
}
