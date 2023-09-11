import 'dart:convert';
import 'package:app_first/model/Userid.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_first/login/singupmix_screen.dart';
import 'package:app_first/menu/home_page.dart';
import 'package:app_first/menu/home_screen.dart';
import 'package:app_first/login/singup_screen.dart';
import 'package:app_first/first_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



import '../firebase_options.dart';
import '../profile/profile_page.dart';
import '../system/cookise.dart';
import '../widgets/Service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
  List<Info> list = [];
class _LoginScreenState extends State<LoginScreen> {


  TextEditingController Emaillogin = TextEditingController();
  TextEditingController PasswordLogin = TextEditingController();
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: 400,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.4),
                ),
                child: TextField( 
                  controller: Emaillogin,//appservice.Emaillogin,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 243, 16, 72),
                      ),
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
                  controller: PasswordLogin,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 243, 16, 72),
                      ),
                    hintText: "Password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  //print("Test");
                  
                  checklogin(Emaillogin.text, PasswordLogin.text,context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
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
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                "Don't have an account?",
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
                    "Signup",
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


void checklogin(String user ,String password,context) {
  
  readfirebase(user,password,context);
  //print(user);
  //print(password);
}

  void initfirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    
  }
//  void readfirebase(user,password,context) async{
//   DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
//   user
//       .where('user', isEqualTo: user)
//       .where('password', isEqualTo: password)
//       .get()
//       .then((QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((val) {
//             print(val['id']);
//             print(val['user']);
//             print(val['name']);
//             cookieset(val['id'], val['user'], val['name']);
//           }));
//  }
 void readfirebase(user,password,context) async {
    //String user = appservice.Emaillogin.text; //กำหนดตัวแปล user แล้วให้เชื่อมกับ appservice แล้วรับค่ามาจากผู้ใช้ก็คือ .Emaillogin.text
    ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: false);
    Useridprovider provideruserid =
        Provider.of<Useridprovider>(context, listen: false);
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> map = json.decode(json.encode(data));
      print(map);
      list = [];
      map.forEach(
        (key, value) {   
          if(user==value["Email"]){  //เช็คเมล userlogin
            if(password==value["Password"]){  //เช็ค pass userlogin
            print(key);
            Fluttertoast.showToast(
                      msg: "ยินดีต้อนรับคุณ "+ value["Name"]+" เข้าสู่ระบบ", gravity: ToastGravity.TOP,
                      backgroundColor: Colors.green
                      );
              String pushemail = user;
              profileService.setemail(user);
              profileService.setkey(key);
              //profileService.setuser(value["Name"],value["Password"],value["Addressshop"],value["Tel"]); //เช็ค login pharmacy
              profileService.setuser(value["Name"],value["Password"],value["Address"],value["Tel"]); //เช็ค Login User 
              provideruserid.addConfig(Userid(email: value["Email"]));

              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(id: pushemail),),);
              // Navigator.push(context, MaterialPageRoute(builder: ((context) => const HomeScreen())));
            }else{
              print("errorpass");
              // Fluttertoast.showToast(
              //         msg: "รหัสผ่านไม่ถูกต้อง", gravity: ToastGravity.TOP,
              //         backgroundColor: Color.fromARGB(255, 243, 16, 72));
            }
          }else{
            print("error");
            // Fluttertoast.showToast(
            //           msg: "ชื่อผู้ใช้และรหัสผ่านไม่ถูกต้อง", gravity: ToastGravity.TOP,
            //           backgroundColor: Color.fromARGB(255, 243, 16, 72));
          }
        },
      );
      list.forEach((element) {
        print("$element");
      });
    });
  }

  class Info {
  final String Email;
  final String Password;

  const Info(
      {required this.Email,
      required this.Password,
      });
}

