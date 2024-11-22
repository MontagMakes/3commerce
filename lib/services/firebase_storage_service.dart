import 'dart:io';

import 'package:e_commerce/main.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;

  // upload image file
  Future<String> uploadImageFile(File imageFile) async {
    try {
      // get reference to the image file
      Reference ref = _storageInstance.ref().child('images/${DateTime.now()}');

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
      Reference ref = _storageInstance.ref().child('models/${DateTime.now()}');

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
      Reference ref = _storageInstance.ref().child(url);

      await ref.delete();

      UploadTask uploadTask = ref.putFile(newFile);

      String downloadUrl = await uploadTask.then((e) => e.ref.getDownloadURL());

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  // delete file from storage using url
  Future<void> deleteFile(String url) async {
    Reference ref = _storageInstance.refFromURL(url);
    await ref.delete();
  }
}
