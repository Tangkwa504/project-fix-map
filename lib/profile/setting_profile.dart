import 'dart:io';


import 'package:app_first/model/User.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../login/login_screen.dart';
import '../widgets/Service.dart';
import 'profile_page.dart';

//ตั้งชื่อตัวแปรต่างๆที่จะนำไปใช้
String Email = "";
String Password = "";
String Name = "";
String Address = "";
String Tel = "";
String Password2 = "";


class settingprofile extends StatefulWidget {
  const settingprofile({super.key});

  @override
  State<settingprofile> createState() => _settingprofileState();
}

class _settingprofileState extends State<settingprofile> {
  TextEditingController ChangeUsername =
      TextEditingController(); // ตั้งค่าชื่อตัวแปรที่รับจากผู้ใช้
  TextEditingController ChangeUserPass = TextEditingController();
  TextEditingController ChangeUserAddress = TextEditingController();
  TextEditingController ChangeUserTel = TextEditingController();
  String? urlsetting; 

  ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    print("test");
    if (pickedFile != null) {
      List<File> images = [];
      File imageFile = File(pickedFile.path);
      images.add(imageFile);
      ProviderSer profileService =
          Provider.of<ProviderSer>(context, listen: false);
      profileService.addFile(images);
    }
  }

  void editfirebase() async {
    ProviderSer userservice =
        Provider.of<ProviderSer>(context, listen: false);
        ModelUsers user = userservice.usermodel;
        ChangeUsername.text = user.username;
        ChangeUserPass.text = user.userpass;
        ChangeUserAddress.text = user.useraddress;
        ChangeUserTel.text = user.usertel;
  }
  
    void setimg() async{
     ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: false);
       urlsetting = await profileService.getProfileImageUrl();
      setState(() {
        
      });
  }


  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    setimg();
    editfirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderSer profiletestService =
        Provider.of<ProviderSer>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "การตั้งค่าบัญชี",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                print(profiletestService.imagesFile2 != null);
                await _pickImage();
                setState(() {});
              },
              child: Align(
                  alignment: Alignment.center,
                  child: profiletestService.imagesFile2 != null
                      ? Image.file(profiletestService.imagesFile2!, width: 200)
                      : Image.network(url!, height: 150,width: 150, fit: BoxFit.cover,))
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: ChangeUsername,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: ChangeUserPass,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: ChangeUserAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: ChangeUserTel,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Tel",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                if (ChangeUsername.text.isNotEmpty &&
                    ChangeUserPass.text.isNotEmpty &&
                    ChangeUserAddress.text.isNotEmpty) {
                      Name = ChangeUsername.text;
                      Address = ChangeUserAddress.text;
                      Password = ChangeUserPass.text;
                      Tel = ChangeUserTel.text;
                  updata(profiletestService);
                  Fluttertoast.showToast(
                      msg: "บันทึกข้อมูลเสร็จสิ้น", gravity: ToastGravity.TOP);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                } else {
                  Fluttertoast.showToast(
                      msg: "โปรดกรอกข้อมูลให้ครบถ้วน",
                      gravity: ToastGravity.TOP);
                }
                // Name = Fullname.text;
                // Address = UserAddress.text;
                // Tel = UserTel.text;
                // updata();
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
              },
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 243, 16, 72),
                ),
                child: const Text(
                  "บันทึกข้อมูล",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

void initfirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("initfirebase");
}



void changefirebase(ProviderSer provider) async {
 

  String path = "User/${provider.keyuser}";
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  await ref.update({
    "Password": Password,
    "Address": Address,
    "Name": Name,
    "Tel": Tel,
  });
  provider.uploadImages();
  url = null;
}

void updata(ProviderSer provider) {
  changefirebase(provider);
}
