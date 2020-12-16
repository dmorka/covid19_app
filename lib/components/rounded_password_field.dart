import 'package:covid19_app/components/text_field_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: Colors.white),
        obscureText: true,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Hasło",
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: backgroundColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: backgroundColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
