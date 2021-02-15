part of 'shared.dart';

Future<File> getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  return File(image.path);
}

Future<String> uploadImage(File image) async {
  String filename = basename(image.path);

  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(filename);
  return await ref
      .putFile(image) //proses upload
      .then((data) => data.ref
          .getDownloadURL()
          .then((url) => url)); //after upload get the download url in string
}
