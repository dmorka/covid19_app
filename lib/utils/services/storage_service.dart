import 'dart:io';
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
//.child('uploads/$fileName');

class FirebaseStorageService {
  static final FirebaseStorageService _instance =
      new FirebaseStorageService._internal();

  factory FirebaseStorageService() => _instance;

  FirebaseStorageService._internal();

  Future<void> uploadAvatar(File image, String userId) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('avatars/$userId')
          .putFile(image);
    } on firebase_core.FirebaseException catch (e) {
      print("Avatar Error!\n" + e.toString());
    }
  }

  Future<void> setAvatar(String userId) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('avatars/$userId')
        .getDownloadURL();
    if (downloadURL == null)
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('avatars/default')
          .getDownloadURL();
    // return downloadURL;
    var documentDirectory = await getApplicationDocumentsDirectory();
    print("////////////////////////");
    print(documentDirectory.path);
    var response = await get(downloadURL);
    File file = new File(
        join(documentDirectory.path, 'profile.jpg')
    );
    file.writeAsBytesSync(response.bodyBytes);
  }

}
