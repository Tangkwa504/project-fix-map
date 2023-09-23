import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../firebase_options.dart';
import '../widgets/Service.dart';
import 'login_screen.dart';

//ตั้งชื่อตัวแปรต่างๆที่จะนำไปใช้
String Email = "";
String Password = "";
String Name = "";
String Address = "";
String Tel = "";
String Password2 = "";
late double lat  ;
late double long ;

class singupmix extends StatefulWidget {
  const singupmix({super.key});

  @override
  State<singupmix> createState() => _singupmixState();
}

class _singupmixState extends State<singupmix> {
  TextEditingController Emailinput =
      TextEditingController(); // ตั้งค่าชื่อตัวแปรที่รับจากผู้ใช้
  TextEditingController UserPass = TextEditingController();
  TextEditingController Checkpass = TextEditingController();
  ImagePicker _picker = ImagePicker();
   bool iserror = false;
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
  bool isValidEmail(String email) {
  // ใช้ Regular Expression เพื่อตรวจสอบรูปแบบอีเมล
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
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
                      ? Image.file(profiletestService.imagesFile2!, width: 200)
                      : Image.asset('assets/addphoto.png', width: 200)),
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
                String user = Emailinput.text.trim();
                 if (!isValidEmail(user)) {
                  Fluttertoast.showToast(
                    msg: "ประเภทของอีเมลที่ใช้สมัครไม่ถูกต้อง",
                    gravity: ToastGravity.TOP,
                  );
                  return;
                }
                DatabaseReference starCountRef =
                    FirebaseDatabase.instance.ref('User');
                starCountRef.onValue.listen((DatabaseEvent event) {
                  final data = event.snapshot.value;
                  Map<String, dynamic> map = json.decode(json.encode(data));
                  print("this is value from user : $user");
                  map.forEach(
                    (key, value) {
                      print("this is value from firebase : ${value['Email']}");
                      if (user == value["Email"].toString()) {
                        //เช็คเมล userlogin
                        setState(() {
                          iserror = true;
                        });
                        print("$iserror = Iserror");
                        print("value has been set true");
                      }
                    },
                  );
                });
                Timer(const Duration(seconds: 1), () {
                  print("value bool : $iserror");
                  if (iserror) {
                    Fluttertoast.showToast(
                        msg: "อีเมลถูกใช้งานแล้ว", gravity: ToastGravity.TOP);
                    return;
                  }
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
                });
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
 
 enum SingingCharacter { pharmacy, user } //enum เป็นตัวแปลคล้ายๆบูลีน
class _singupmix2State extends State<singupmix2> {
  TextEditingController Fullname = TextEditingController();
  TextEditingController UserAddress = TextEditingController();
  TextEditingController UserTel = TextEditingController();
   Position? userLocation;
  
  
  //SingingCharacter? _character = SingingCharacter.user; //เรียกใช้ enum

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    _getLocation();
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
            InkWell(
              onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MapLocationPicker(
                            apiKey: "AIzaSyAqyETt9iu7l5QioWz5iwEbzrallQrpzLs",
                            popOnNextButtonTaped: true,
                            currentLatLng: LatLng(userLocation!.latitude,userLocation!.longitude),
                            onNext: (GeocodingResult? result) {
                              if (result != null) {
                                Location latlong = result.geometry.location;
                                setState(() {
                                  print("1=============> ${result.formattedAddress}");
                                  UserAddress.text = result.formattedAddress.toString();
                                  print("=============> ${latlong.lat}");
                                  print("=============> ${latlong.lng}");
                                  lat  = latlong.lat;
                                  long = latlong.lng;
                                });
                              }
                            },
                            onSuggestionSelected:
                                (PlacesDetailsResponse? result) {
                              if (result != null) {
                                setState(() {
                                  print(result.result.geometry!.location);
                                  result.result.formattedAddress ?? "";
                                });
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.4),
                ),
                child: TextField(
                  enabled: false,
                  controller: UserAddress,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Address",
                    border: InputBorder.none,
                  ),
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
                    UserAddress.text.isNotEmpty &&
                    UserTel.text.isNotEmpty) {
                  Name = Fullname.text;
                  Address = UserAddress.text;
                  Tel = UserTel.text;
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
      String rendomString = getRandomString(10);
  String path = "User/${rendomString}";
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  await ref.set({
    "Id": rendomString,
    "Email": Email,
    "Password": Password,
    "Address": Address,
    "Name": Name,
    "Tel": Tel,
  });

  provider.setemail(Email,rendomString);
  provider.uploadImages();
  provider.createcol(Email);
}

void updata(ProviderSer provider) {
  writefirebase(provider);
}
