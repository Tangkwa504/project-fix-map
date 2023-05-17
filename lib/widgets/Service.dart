import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//เก็บข้อมูลตัวแปลไว้ เพื่อกระจายไปยังหน้าต่างๆ
Appservice appservice = Appservice();

class Appservice {
  String email = "";
  TextEditingController Emaillogin = TextEditingController();
}

class ProviderSer extends ChangeNotifier {
  String reademail = "";
  List<File> imgfile = [];
  List<String> imgurl = [];
  String? url; 
  File? imgtest; 
  final FirebaseStorage store = FirebaseStorage.instance;
  // ProviderSer(this.store);
  List<File> get imagesFile => imgfile;
  File? get imagesFile2 => imgtest;

void logout () {
 reademail = "";
 imagesFile.clear();
 imgurl.clear();
 url = null;
 imgtest = null;
}


void addFile(List<File> images) {
    imgfile.addAll(images);
    notifyListeners();
    imgtest = File(images.first.path);
    notifyListeners();
  }

  void setemail(String mail) async{
    reademail = mail;
    url = await getProfileImageUrl();
    print("gsehwhjersdhjserhjswh" + reademail);
    print(url);
    notifyListeners();
  }

Future<String?> getProfileImageUrl() async {
    try {
      final ref = store.ref('users/$reademail/image');
      final result = await ref.listAll();
      if (result.items.isNotEmpty) {
        final url = await result.items.first.getDownloadURL();
        print(url);
        return url;
      }
      return null;
    } catch (e) {
      print('Error getting profile image URL: $e');
    }
    return null;
  }

  Future<void> uploadImages() async {

    if (reademail == "") {
      notifyListeners();
    }

    if (imgfile.isEmpty) {
      notifyListeners();
    }

    try {
      for (int i = 0; i < imgfile.length; i++) {
        String imageName = const Uuid().v4();
        final Reference storageRef =
            FirebaseStorage.instance.ref('users/${reademail}/image/$imageName');
        final UploadTask uploadTask = storageRef.putFile(imgfile[i]);
        final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {
          print("Upload for ${reademail} with Image $imageName");
        });
        final String url = await downloadUrl.ref.getDownloadURL();
        imgurl.add(url);
      }
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      imgfile.clear();
      notifyListeners();
    }
  }
}
