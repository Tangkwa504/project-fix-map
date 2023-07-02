import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../widgets/Service.dart';
import 'login_screen.dart';

//ตั้งชื่อตัวแปรต่างๆที่จะนำไปใช้
String Email = "";
String Password = "";
String Name = "";
String Licensepharmacy = "";
String Tel = "";
String Password2 = "";
String Nameshop = "";
String Addressshop = "";
String Timeopening = "";
String Timeclosing = "";

class singupmixpharmacy extends StatefulWidget {
  const singupmixpharmacy({super.key});

  @override
  State<singupmixpharmacy> createState() => _singupmixpharmacyState();
}

class _singupmixpharmacyState extends State<singupmixpharmacy> {
  TextEditingController Emailinput = TextEditingController(); // ตั้งค่าชื่อตัวแปรที่รับจากผู้ใช้
  TextEditingController UserPass = TextEditingController();
  TextEditingController Checkpass = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    // ImagePicker _picker = ImagePicker();
    // Future<void> _pickImage(String uid) async {
    //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     List<File> images = [];
    //     File imageFile = File(pickedFile.path);
    //     images.add(imageFile);
    //     ProviderSer profileService =
    //         Provider.of<ProviderSer>(context, listen: false);
    //     profileService.addFile(images);
    //   }
    // }
    ProviderSer profiletestService =
        Provider.of<ProviderSer>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              "Register",
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
                setState(() {
                
              });
              },
              child: Align(
                  alignment: Alignment.center,
                  child: profiletestService.imagesFile2 != null
                      ? Image.file(profiletestService.imagesFile2!, width: 200, height: 220)
                      : Image.asset('assets/addphoto.png', width: 200, height: 220)),
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
                controller: Emailinput,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Email address",
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
                controller: UserPass,
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
                controller: Checkpass,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                if (Emailinput.text.isNotEmpty &&
                    UserPass.text.isNotEmpty &&
                    Checkpass.text.isNotEmpty &&
                    UserPass.text == Checkpass.text) {
                  Email = Emailinput.text;
                  Password = UserPass.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const singupmix2(),
                      ));
                } else if (UserPass.text != Checkpass.text) {
                  Fluttertoast.showToast(
                      msg: "รหัสผ่านไม่ตรงกัน", gravity: ToastGravity.TOP);
                } else {
                  Fluttertoast.showToast(
                      msg: "โปรดกรอกข้อมูลให้ครบถ้วน",
                      gravity: ToastGravity.TOP);
                }
                // Email = Emailinput.text;
                // Password = UserPass.text;
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const singupmix2(),));
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
                  "NEXT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginScreen())));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class singupmix2 extends StatefulWidget {
  const singupmix2({super.key});

  @override
  State<singupmix2> createState() => _singupmix2State();
}
 
//enum เป็นตัวแปลคล้ายๆบูลีน
class _singupmix2State extends State<singupmix2> {
  TextEditingController Fullname = TextEditingController();
  TextEditingController Pharmacylicense = TextEditingController();
  TextEditingController UserTel = TextEditingController();
  
  

  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Align(alignment: Alignment.center, child: Image.asset('assets/logo.png', width: 200)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Fullname,
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
                controller: Pharmacylicense,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Pharmacylicense",
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
                controller: UserTel,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Tel:",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                if (Fullname.text.isNotEmpty &&
                    Pharmacylicense.text.isNotEmpty &&
                    UserTel.text.isNotEmpty) {
                  Name = Fullname.text;
                  Licensepharmacy = Pharmacylicense.text;
                  Tel = UserTel.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const singupmix3(),
                      ));

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
                  "NEXT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginScreen())));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class singupmix3 extends StatefulWidget {
  const singupmix3({super.key});

  @override
  State<singupmix3> createState() => _singupmix3State();
}
 
//enum เป็นตัวแปลคล้ายๆบูลีน
class _singupmix3State extends State<singupmix3> {
  TextEditingController Shopname = TextEditingController();
  TextEditingController Shopaddress = TextEditingController();
  TextEditingController Openingtime = TextEditingController();
  TextEditingController Closingtime = TextEditingController();
    ImagePicker _picker = ImagePicker();
    ImagePicker _pickershop = ImagePicker();
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
  Future<void> _pickImageshop() async {
    final pickedFile = await _pickershop.pickImage(source: ImageSource.gallery);
    print("test");
    if (pickedFile != null) {
      List<File> images = [];
      File imageFile = File(pickedFile.path);
      images.add(imageFile);
      ProviderSer profileService =
          Provider.of<ProviderSer>(context, listen: false);
      profileService.addFileshop(images);
    }
  }
  
  

  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: true);
        
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Shop Detail",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Align(alignment: Alignment.center, child: Image.asset('assets/logo.png', width: 200)),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                print(profileService.imagesFile2shop != null);
                await _pickImageshop();
                setState(() {
                
              });
              },
              child: Align(
                  alignment: Alignment.center,
                  child: profileService.imagesFile2shop != null
                      ? Image.file(profileService.imagesFile2shop!, width: 200, height: 220)
                      : Image.asset('assets/addphoto.png', width: 200, height: 220)),
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
                controller: Shopname,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Shopname",
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
                controller: Shopaddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Shopaddress",
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
                controller: Openingtime,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Openingtime",
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
                controller: Closingtime,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Closingtime",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                if (Shopname.text.isNotEmpty &&
                    Shopaddress.text.isNotEmpty &&
                    Openingtime.text.isNotEmpty &&
                    Closingtime.text.isNotEmpty) {
                  Nameshop = Shopname.text;
                  Addressshop = Shopaddress.text;
                  Timeopening = Openingtime.text;
                  Timeclosing = Closingtime.text;
                  updata(profileService);
                  Fluttertoast.showToast(
                      msg: "Insert Success", gravity: ToastGravity.TOP);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
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
                  "REGISTER",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
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

void writefirebase(ProviderSer provider) async {
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String path = "User/${getRandomString(10)}";
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  await ref.set({
    "Email": Email,
    "Password": Password,
    "Licensepharmacy": Licensepharmacy,
    "Name": Name,
    "Tel": Tel,
    "Nameshop" : Nameshop, 
    "Addressshop" : Addressshop,
    "Timeopening" : Timeopening,
    "Timeclosing" : Timeclosing,


  });
  provider.setemail(Email);
  provider.uploadImages();
  provider.uploadImagesshop();
  provider.createcol(Email);
}

void updata(ProviderSer provider) {
  writefirebase(provider);
}
