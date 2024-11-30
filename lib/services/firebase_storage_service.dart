import 'dart:io';

import 'package:e_commerce/main.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;

  // upload image file to storage and return the download url
  Future<String> uploadImageFile(File imageFile) async {
    try {
      // get reference to the storage location
      Reference ref = _storageInstance.ref().child('images/${DateTime.now()}');

      // upload the file to the location and get the download url
      String downloadUrl = await ref
          .putFile(imageFile)
          .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  // upload model file
  Future<String> uploadModelFile(File modelFile) async {
    try {
      // get reference to the storage location
      Reference ref = _storageInstance.ref().child('models/${DateTime.now()}');

      // upload the file to the location and get the download url
      String downloadUrl = await ref
          .putFile(modelFile)
          .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  // delete file from storage using url
  Future<void> deleteFile(String url) async {
    if (url.isEmpty) return;
    try {
      Reference ref = _storageInstance.refFromURL(url);
      await ref.delete();
    } catch (e) {
      logger.e(e);
    }
  }
}
