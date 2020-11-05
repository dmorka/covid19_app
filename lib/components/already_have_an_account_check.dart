import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an account?" : "Already have an account?",
          style: TextStyle(color: mainColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? " Sign Up!" : " Sign In!",
            style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
