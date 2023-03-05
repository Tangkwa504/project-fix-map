import 'dart:convert';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Info> list = [];

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    initfirebase();
    super.initState();
  }

  void readfirebase() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('beta');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> map = json.decode(json.encode(data));
      print(map);
      list = [];
      map.forEach(
        (key, value) {
          if (key != "b") {
            print("${value}");
            list.add(
              Info(
                  name: value["name"],
                  age: value["age"] ?? 0,
                  inActive: value["active"] ?? false,
                  id: key.toString()),
            );
          }
        },
      );
      list.forEach((element) {
        print("$element");
      });
      setState(() {});
    });
  }

  void Del(Info info) async {
    String path = info.id;
    print(path);
    DatabaseReference ref = FirebaseDatabase.instance.ref("data/${path}");

    await ref.update({
      "active": false,
    });
  }

  void initfirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    readfirebase();
  }

  void writefirebase() async {
    String path = "data/${getRandomString(10)}";
    DatabaseReference ref = FirebaseDatabase.instance.ref(path);
    await ref.set({
      "name": name.text,
      "age": int.parse(age.text),
      "active": true,
    });
    name.clear();
    age.clear();
  }

  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar"),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: TextField(
                controller: name,
                decoration: InputDecoration(hintText: "name")),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: TextField(
                controller: age, decoration: InputDecoration(hintText: "age")),
          ),
          Expanded(
            child: Column(
              children: List.generate(
                  list.length,
                  (index) => list[index].inActive
                      ? Row(
                          children: [
                            Text("${list[index].name} ${list[index].age}"),
                            MaterialButton(
                              onPressed: () => Del(list[index]),
                              child: const Text("Delete"),
                            )
                          ],
                        )
                      : Container()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => writefirebase(),
        child: const Text("Save"),
      ),
    );
  }
}

class Info {
  final String name;
  final int age;
  final bool inActive;
  final String id;
  const Info(
      {required this.name,
      required this.age,
      required this.inActive,
      required this.id});
}