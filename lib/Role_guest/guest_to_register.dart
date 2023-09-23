import 'package:app_first/login/singupmix_screen.dart';

import 'package:app_first/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';



class forceregister extends StatelessWidget {
  const forceregister({super.key});
  

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
                  "ระบบนี้ต้องมีบัญชีในการเข้าถึง" ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.black87,
              ),
              ),
              const Text(
                  "กรุณาเข้าสู่ระบบก่อนการใช้งาน" ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black87,
              ),
              ),
              const SizedBox(height: 20),
              
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
                    "เข้าสู่ระบบ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                "หากคุณยังไม่มีบัญชี?",
                style: TextStyle( 
                  color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const singupmix()))); 
                  },
                  child: const Text(
                    "สมัครสมาชิก",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}