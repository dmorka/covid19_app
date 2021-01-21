import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

onImageButtonPressed(ImageSource source,
    {BuildContext context, capturedImageFile}) async {
  final ImagePicker _picker = ImagePicker();
  File val;

  final pickedFile = await _picker.getImage(
    source: source,
  );

  val = await ImageCropper.cropImage(
    sourcePath: pickedFile.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    compressQuality: 100,
    maxHeight: 200,
    maxWidth: 200,
    compressFormat: ImageCompressFormat.jpg,
    androidUiSettings: AndroidUiSettings(
      toolbarColor: Colors.white,
      toolbarTitle: "Set avatar",
    ),
  );
  print("cropper ${val.runtimeType}");
  capturedImageFile(val.path);

}

typedef capturedImageFile = String Function(String);
typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);