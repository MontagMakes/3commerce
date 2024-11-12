import 'dart:io';

import 'package:e_commerce/main.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // upload image file
  Future<String> uploadImageFile(File imageFile) async {
    try {
      // get reference to the image file
      Reference ref = _firebaseStorage.ref().child('images/${DateTime.now()}');

      // put the file in the reference
      UploadTask uploadTask = ref.putFile(imageFile);

      // get the download url
      String downloadUrl = await uploadTask.then((e) => e.ref.getDownloadURL());

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  // upload model file
  Future<String> uploadModelFile(File modelFile) async {
    try {
      // get the reference to the model file
      Reference ref = _firebaseStorage.ref().child('models/${DateTime.now()}');

      // put the file in the reference
      UploadTask uploadTask = ref.putFile(modelFile);

      // get the download url
      String downloadUrl = await uploadTask.then((e) => e.ref.getDownloadURL());

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  // replace file in storage using url
  Future<String> replaceFile(File newFile, String url) async {
    try {
      Reference ref = _firebaseStorage.ref().child(url);

      await ref.delete();

      UploadTask uploadTask = ref.putFile(newFile);

      String downloadUrl = await uploadTask.then((e) => e.ref.getDownloadURL());

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  String getFileName(String url) {
    Reference ref = _firebaseStorage.refFromURL(url);
    String name = ref.name;
    return name;
  }

  // delete file from storage using url
  Future<void> deleteFile(String url) async {
    Reference ref = _firebaseStorage.refFromURL(url);
    await ref.delete();
  }
}
