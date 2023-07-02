import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Shopprofile extends StatefulWidget {
  const Shopprofile({super.key});

  @override
  State<Shopprofile> createState() => _ShopprofileState();
}

class _ShopprofileState extends State<Shopprofile> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดร้านขายยา'),
      ),
      body: Container(
         child: SingleChildScrollView(
          child: Column(
            children:  [
              const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black87,
                  ),
              ),
              const SizedBox(height: 12),
              Align(alignment: Alignment.center, child: Image.asset('assets/logo.png', width: 200)),
              const SizedBox(height: 12),
              const Text(
                  "ชื่อร้าน",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 64,
                    color: Colors.black87,
                  ),
              ),
              const SizedBox(height: 12),
              const Text(
                  "ที่ตั้งร้าน",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black87,
                  ),
              ),     
              const SizedBox(height: 12),
              const Text(
                  "เวลาเปิดปิด",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Color.fromARGB(221, 0, 47, 255),
                  ),
              ),     
              const SizedBox(height: 12),
              const Text(
                  "ชื่อ เภสัชกร",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(221, 95, 93, 93),
                  ),
              ),    
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),));
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
                    "ปรึกษาเภสัชกร",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          
         ),
      ),
      
    );
    
  }
}