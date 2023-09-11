import 'package:app_first/menu/home_screen.dart';
import 'package:app_first/first_page.dart';
import 'package:app_first/login/login_screen.dart';
import 'package:app_first/profile/setting_profile.dart';
import 'package:app_first/widgets/Service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatmockup.dart';
import 'login/login_test.dart';

void main()async{ 
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     //appservice.email = "1"; // คำสั่งกำหนดค่าให้ตัวแปรที่จะเก็บเข้า Service
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => ProviderSer()),
        ChangeNotifierProvider(create:(_) => ProductProvider()),
        ChangeNotifierProvider(create:(_) => CartProvider()),
        ChangeNotifierProvider(create:(_) => Useridprovider()),
        
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FirstPage(),
      ),
    );
  }
}

