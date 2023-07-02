import 'package:app_first/first_page.dart';
import 'package:app_first/profile/profile_page.dart';
import 'package:app_first/login/singup_screen.dart';
import 'package:app_first/widgets/bottonhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Products/Productspage.dart';
import '../Role_guest/bottomhomeguest.dart';
import '../Role_pharmacy/shopprofile.dart';
import '../login/login_screen.dart';
import '../map/map.dart';

class HomePageguest extends StatefulWidget {
  const HomePageguest({super.key});

  @override
  State<HomePageguest> createState() => _HomePageguestState();
}

class _HomePageguestState extends State<HomePageguest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(  
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [ 
            Align(alignment: Alignment.center, child: Image.asset('assets/logo.png', width: 230)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Bottonhomeguest(title: "ค้นหาอัตโนมัติ",page: Shopprofile(),icon: Icons.refresh),
                Bottonhome(title: "ค้นหาร้านยา",page: MapsPage(),icon: Icons.pin_drop),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Bottonhomeguest(title: "QRCODE",page: ProductsPage(),icon: Icons.qr_code),
                Bottonhomeguest(title: "ประวัติสนทนา",page: LoginScreen(),icon: Icons.chat),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

