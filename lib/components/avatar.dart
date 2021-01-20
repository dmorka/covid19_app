import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/utils/services/storage_service.dart';
import 'package:provider/provider.dart';

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
  String _avatar;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: FirebaseStorageService().setAvatar(context.read<User>().uid),

      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

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
              image: snapshot.hasData ? NetworkImage(snapshot.data) : AssetImage("assets/images/profile.jpg"),
            ),
          ),
        );
      });
  }
}