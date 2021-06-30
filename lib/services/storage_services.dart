import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class StorageServices {
  static Future<String> uploadImage(File imgFile) async {
    String fileName = basename(imgFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);

    UploadTask task = ref.putFile(imgFile);
    return await (await task).ref.getDownloadURL();
  }

  static Future<File> getImage() async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
