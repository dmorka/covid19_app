import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Avatar extends StatefulWidget {
  final double height;
  final double width;

  const Avatar({
    Key key,
    this.height,
    this.width
  }) : super(key: key);

  _Avatar createState() => _Avatar();
}

class _Avatar extends State<Avatar> {
  File _avatar;
  double height;
  double width;

  _Avatar() {
    getAvatar().then((val) => setState(() {
      _avatar = val;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: _avatar == null ? AssetImage("assets/images/profile.jpg") : FileImage(_avatar),
        ),
      ),
    );
  }
  Future<File> getAvatar() async {
    print("get-----------");
    final directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    return File('$dir/profile.jpg');
  }
}