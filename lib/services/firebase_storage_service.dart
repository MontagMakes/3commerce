import 'dart:io';

import 'package:e_commerce/main.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String uploadImageFile(File imageFile) {
    String url = '';
    Reference ref = _firebaseStorage.ref().child('images/${DateTime.now()}');

    UploadTask uploadTask = ref.putFile(imageFile);

    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      logger.d('Image URL IS HERE :$url');
    }).catchError((e) {
      logger.e(e);
      return e;
    });

    return url;
  }

  String uploadModelFile(File modelFile) {
    String url = '';

    Reference ref = _firebaseStorage.ref().child('models/${DateTime.now()}');

    UploadTask uploadTask = ref.putFile(modelFile);

    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      logger.d('Model URL IS HERE :$url');
    }).catchError((e) {
      logger.e(e);
      return e;
    });

    return url;
  }
}
