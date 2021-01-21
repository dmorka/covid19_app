import 'dart:io';

import 'package:covid19_app/components/rounded_button.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:covid19_app/utils/camera_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid19_app/utils/services/storage_service.dart';
import 'package:provider/provider.dart';

class AvatarDialog extends StatefulWidget {
  AvatarDialog({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AvatarDialog();
}

class _AvatarDialog extends State<AvatarDialog> {
  File _imageFile;
  // _AvatarDialog();

  @override
  Widget build(BuildContext context) {
    final userId = context.read<User>().uid;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RoundedButton(
                  text: "Camera",
                  press: () {
                    onImageButtonPressed(
                      ImageSource.camera,
                      context: context,
                      capturedImageFile: (s) {
                        FirebaseStorageService()
                            .uploadAvatar(new File(s), userId, context);
                        // setState(() {
                        //   // _imageFile = new File(s);
                        // });
                      },
                    );
                    Navigator.pop(context);
                  }),
              SizedBox(height: 25),
              RoundedButton(
                  text: "Gallery",
                  press: () {
                    onImageButtonPressed(
                      ImageSource.gallery,
                      context: context,
                      capturedImageFile: (s) {
                        FirebaseStorageService()
                            .uploadAvatar(new File(s), userId, context);
                        // setState(() {
                        //   // _imageFile = new File(s);
                        // });
                      },
                    );
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
