import 'package:app_first/login/login_screen.dart';
import 'package:app_first/login/singup2_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

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
              child: const TextField( 
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
              child: const TextField( 
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Singup2Screen(),));
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