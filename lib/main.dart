// Root of the aplication

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'covid19_APP',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: "Ubuntu",
    )
    home: IntroPage(),
  );
}