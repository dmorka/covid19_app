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
          login ? "Nie masz konta?" : "Posiadasz już konto?",
          style: TextStyle(color: mainColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? " Zarejestruj się!" : " Zaloguj się!",
            style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
