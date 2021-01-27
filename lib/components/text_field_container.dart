import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const TextFieldContainer({Key key, this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: backgroundColor ?? mainColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
