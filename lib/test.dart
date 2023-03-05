import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'firebase_options.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  List users = [];  //สร้างอาเรย์เก็บ user จาก firebase
  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    super.initState();
  }
  void initfirebase () async{
 
  readfirebase();
}
void readfirebase () async{
  print("read");
  DatabaseReference ref =
        FirebaseDatabase.instance.ref('test'); // ดึงข้อมูลจาก key หลักของ database
  ref.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    Map<String, dynamic> map = json.decode(json.encode(data));
    print("data ${ data.runtimeType }");
    
    //print(event);
    //print(data);
    print(map);
    users.clear();
    map.forEach((key, value) {  // อ่านข้อมูลจาก database
      print("key ${ key }");
      print("value ${ value }");
      users.add(value);
    });
    setState(() {
      
    });
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test"),
      ),
      body: Center(
        child: Column(
          children: 
          List.generate(users.length, (index) => Text("${users[index]["user"]}"))
          ),
        ),
    );
    
 
  }
}



