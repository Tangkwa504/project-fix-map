import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../firebase.dart';
import '../firebase_options.dart';
import '../first_page.dart';
import '../login/login_screen.dart';
import '../widgets/alertdialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
List users = [];

class _ProfilePageState extends State<ProfilePage> {
    @override
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
  void initState() {
    // TODO: implement initState
    initfirebase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    readfirebase();
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.maxFinite,
              decoration: BoxDecoration(  
                gradient: LinearGradient(colors: <Color>[ 
                        Color.fromARGB(255, 224, 20, 214),
                        Color(0xff8F6ED5),
                        Color.fromARGB(255, 25, 128, 224),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 30,
            right: 30,
            left: 30,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [                  
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("???????????????", style: TextStyle(  
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              Text("Test@email.com", style: TextStyle(  
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                        InkWell(
              onTap: () {                
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstPage(),));
              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 131, 126, 127),
                ),
                child: const Text( 
                  "EDIT PROFILE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
                    InkWell(
              onTap: () async {
                 final action = await AlertDialogs.yesCancleDialog(
                  context, 'Logout', '????????????????????????????????????????????????????????????????????????????????????????????? ?');
              if (action == DialogAction.Yes) {
                Fluttertoast.showToast(
                      msg: "Logout Success", gravity: ToastGravity.TOP,
                      backgroundColor: Color.fromARGB(255, 243, 16, 72));
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstPage(),));
              };
              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 243, 16, 72),
                ),
                child: const Text( 
                  "LOGOUT",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          

          //image
          Positioned(
            top: 75,
            left: MediaQuery.of(context).size.width / 2 - 75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: Image.asset(
                "assets/profile.png",
                height: 150, 
                width: 150, 
                fit: BoxFit.cover,
                ),
                ),
          ),

        ],
        ),
    );
  }
    void readfirebase() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> map = json.decode(json.encode(data));
      print(map);
      list = [];
      map.forEach(
        (key, value) {
          Text(value["name"]);
          //print(key);     
        },
      );
      list.forEach((element) {
        print("$element");
      });
    });
  }
}


  void initfirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

  }


