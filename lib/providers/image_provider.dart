import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageProvider {
  static Future<File> selectImageFromGallery() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return null;

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Edit Image",
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    return croppedFile;
  }

  static Future<String> uploadImageToFirestore(File file, String uid) async {
    var ref = FirebaseStorage.instance.ref('userProfilePictures/$uid');
    UploadTask uploadTask = ref.putFile(file);
    final String imgUrl = await uploadTask
        .then((TaskSnapshot taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return imgUrl;
  }
}
