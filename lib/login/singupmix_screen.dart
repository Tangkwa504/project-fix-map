import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase_options.dart';
import 'login_screen.dart';
//ตั้งชื่อตัวแปรต่างๆที่จะนำไปใช้
String Email = "";
String Password = "";
String Name = ""; 
String Address = "";
String Tel = "";

class singupmix extends StatefulWidget {
  const singupmix({super.key});

  @override
  State<singupmix> createState() => _singupmixState();
}

class _singupmixState extends State<singupmix> {
  TextEditingController Emailinput = TextEditingController(); // ตั้งค่าชื่อตัวแปรที่รับจากผู้ใช้
  TextEditingController UserPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color:Colors.black87),
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
              child: const TextField( 
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
                Email = Emailinput.text;
                Password = UserPass.text;
                Navigator.push(context, MaterialPageRoute(builder: (context) => const singupmix2(),));
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => const LoginScreen()))); 
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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

class _singupmix2State extends State<singupmix2> {
  TextEditingController Fullname = TextEditingController();
  TextEditingController UserAddress = TextEditingController();
  TextEditingController UserTel = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color:Colors.black87),
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
                controller: UserAddress,
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
                Name = Fullname.text;
                Address = UserAddress.text;
                Tel = UserTel.text;
                updata();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => const LoginScreen()))); 
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
      print("initfirebase");
  }
  void writefirebase() async {
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
      "Address": Address,
      "Name": Name,
      "Tel": Tel,
      
    });
  }
  


void updata() {
writefirebase();
}

