import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../first_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                              Text("องุ่น", style: TextStyle(  
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstPage(),));
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
}
