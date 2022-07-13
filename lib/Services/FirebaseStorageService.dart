import 'dart:io';
import 'package:consolelovers/Services/StorageBase.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late Reference _storageRef;
  @override
  Future<String> uploadFile(
      String consoleID, String fileType, File uploadedFile) async {
    _storageRef = _firebaseStorage
        .ref()
        .child(consoleID)
        .child(fileType)
        .child("Console_photo.png");

    UploadTask uploadTask = _storageRef.putFile(uploadedFile);
    var url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
