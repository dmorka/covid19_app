import 'package:covid19_app/components/text_field_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: TextFieldContainer(
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          cursorColor: Colors.purple[700],
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: backgroundColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
