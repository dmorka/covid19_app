import 'dart:io';
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

final firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
//.child('uploads/$fileName');

class FirebaseStorageService {
  static final FirebaseStorageService _instance =
  new FirebaseStorageService._internal();

  factory FirebaseStorageService() => _instance;

  FirebaseStorageService._internal();

  Future<void> uploadAvatar(File image, String userId) async {
    // firebase_storage.Reference ref =
    // TaskSnapshot snapshot = await storage
    //     .ref()
    //     .child('avatars/$userId')
    //     .putFile(image)
    //     .whenComplete(() => print("Successfully added!"));

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('avatars/$userId')
          .putFile(image);
    } on firebase_core.FirebaseException catch (e) {
      print("Avatar Error!\n" + e.toString());
    }


  }
}