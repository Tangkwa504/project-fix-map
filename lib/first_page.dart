import 'dart:async';

import 'package:app_first/login/singupmix_screen.dart';
import 'package:app_first/menu/home_screen.dart';
import 'package:app_first/login/login_screen.dart';
import 'package:app_first/login/singup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'login/singup_pharmacy.dart';
import 'menu/home_screenguest.dart';
import 'widgets/Service.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    // TODO: implement initState
    init();
    Timer(Duration(seconds: 1), () {
    checkuserid();
  });
    
    super.initState();
  }
  void checkuserid() {
    Useridprovider provideruserid =
        Provider.of<Useridprovider>(context, listen: false);
        var userid = provideruserid.getuserid();
        int count = userid.length;
        print("Login count = "+count.toString());
        if(count != 0){
          Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(id: userid.last.email),),);
          }        
  }
  void init(){
    Provider.of<Useridprovider>(context, listen: false).init();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      
      body: Container(
        
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children:  [
              Align(alignment: Alignment.center, child: Image.asset('assets/logo.png', width: 230)),
              const SizedBox(height: 12),
              const Text(
                  "Pharmacy" ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                    color: Colors.black87,
              ),
              ),
              const Text(
                  "Online" ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                    color: Colors.black87,
              ),
              ),
              const SizedBox(height: 50),
              
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration( 
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 64, 103, 211),
                  ),
                  child: const Text( 
                    "LOGIN",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const singupmix(),));
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
                    "REGISTER",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenguest(id: 'guset',),));
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
                    "CONTINUE AS GUEST",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}