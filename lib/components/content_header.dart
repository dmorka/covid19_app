import 'package:flutter/material.dart';

class ContentHeader extends StatelessWidget {

  final String name;

  ContentHeader({this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black87,
        ),
      ),
    );
  }

}