import 'package:app_first/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../menu/home_screen.dart';
import '../login/login_screen.dart';
import '../login/singup_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color:Colors.black87),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      
      body: Container(
        
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children:  [
            Align(alignment: Alignment.center, child: Image.asset('assets/CX.jpg', width: 230)),
            const SizedBox(height: 12),
            const Text(
                "เจ้าแมวน้อย ตัวแสบ" ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black87,
            ),
            ),
            const Text(
                "catback@gmail.com" ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
            ),
            ),
            const SizedBox(height: 80),
                        InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
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
                  "SETTING PROFILE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstPage(),));
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
    );
    
  }
}