import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:department_web/util/const.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static var storageRef = FirebaseStorage.instance.ref();

  static addToFireBase(String collectionName) async {
    fireStore.collection(collectionName).get().then((value) {
      return value.docs;
    });
  }

  static addToStorage(String fileNameInput, Uint8List file) async {
    var storageRef = FirebaseStorage.instance.ref();

    storageRef = storageRef.child(ConstData.getRandomString(8) + fileNameInput);
    final upload = storageRef.putData(file);
    final url = await upload.whenComplete(() {});
    return await url.ref.getDownloadURL();
  }
}
