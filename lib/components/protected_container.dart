import 'package:covid19_app/pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProtectedContainer extends StatefulWidget {
  const ProtectedContainer({
    Key key,
    this.body,
  }) : super(key: key);

  final Widget body;

  @override
  _ProtectedContainerState createState() => _ProtectedContainerState();
}

class _ProtectedContainerState extends State<ProtectedContainer> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return firebaseUser != null ? widget.body : IntroPage();
  }
}
