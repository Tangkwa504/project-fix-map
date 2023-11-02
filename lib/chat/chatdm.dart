import 'dart:async';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Service.dart';
import 'chat.dart';

class chatdm extends StatefulWidget {
  @override
  _chatdmState createState() => _chatdmState();
}

class _chatdmState extends State<chatdm> {
  
    String sender = "";
    String receiver = "";
    String room = "";
    List<String> chatKeys = [];
    List msg = [];
    List<DirectMessage> dmList = [];
    late DatabaseReference chatRef ;
    late StreamSubscription<DatabaseEvent> subscription ;


   @override
   void initState() {
    Start();
    // TODO: implement initState
    super.initState();
  }
 void Start() {
  
  ProviderSer profileService = Provider.of<ProviderSer>(context, listen: false);
  chatRef = FirebaseDatabase.instance.ref('User/${profileService.readid}/chat');
  sender = profileService.readid;
  print("sender=== $sender");
  subscription = chatRef.onValue.listen((DatabaseEvent event) {
    if (event.snapshot.exists) {
      Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;
      print("data === $data");
      List<String> receiverList = data.keys.toList().cast<String>(); // แปลงคีย์ใน Map ให้เป็น List
      
      // ตรวจสอบว่ารายการไม่ว่าง
      if (receiverList.isNotEmpty) {
        print("receiverList = $receiverList");
        ondmcreated(receiverList);
 
      }

    }
    
  });
  
}

  Future<void> ondmcreated(List<String> receiverList) async {
  ProviderSer profileService = Provider.of<ProviderSer>(context, listen: false);
  sender = profileService.readid;

  for (String receiver in receiverList) {
    String receiverPath = 'Pharmacy/$receiver';
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref(receiverPath);

    try {
      DatabaseEvent event = await starCountRef.once();
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;

        String dmEmail = data['Email'];
        String dmId = data['Id'];
        String dmusername = data['Name'];
        String dmshopname = data['Nameshop'];
        String? url = await profileService.getProfileshopImageUrl(dmEmail);

        createdm(dmId, dmEmail, dmusername,dmshopname, sender, url);
        print('Added marker with id=$dmId, dmEmail=$dmEmail, dmusername=$dmusername,dmshopname=$dmshopname,Pic=$url, Sender=$sender');
      }
    } catch (error) {
      // Handle any errors that might occur during the data retrieval.
      print('Error: $error');
    }
  }
}
  void createdm(String id,String email,String name,String shopname,String sender,String? url){
    List<DirectMessage> dmcreate = [
    DirectMessage(
      userId: id,
      receiverId:email,
      username: name,
      shopname: shopname,
      senderId: sender,
      userImage: url ?? 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
    ),
    // เพิ่มรายชื่อ DMs ตามต้องการ
  ];
    setState(() {
    dmList.addAll(dmcreate);
    });

  print("dmlist === ${dmList}");
  }

// void getroom(receiverList) {
//   ProviderSer profileService = Provider.of<ProviderSer>(context, listen: true);
//     DatabaseReference starCountRef =
//         FirebaseDatabase.instance.ref('Pharmacy/${profileService.readid}/chat/${receiverList}');
//     starCountRef.onValue.listen((DatabaseEvent event) {
//       print(event.snapshot.value);
//       String checkroom = "${event.snapshot.value.toString()}";
//       if(checkroom == "null"){
        
//       }else{
//       room = event.snapshot.value.toString();

  
//       }
//     });
//   }

@override
  void dispose() {
    // subscription.cancel();

    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติการสนทนา'),
      ),
      body: ListView.builder(
  itemCount: dmList.length,
  itemBuilder: (context, index) {
    final dm = dmList[index];
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  receiverId: dm.userId,
                  chatName: dm.username,
                  image: dm.userImage,
                  senderId: dm.senderId,
                ),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(dm.userImage),
          ),
          title: Text(dm.username),
          subtitle: Text(dm.shopname),
            trailing: Text("dm.lastMessageTime"),
        ),
        SizedBox(height: 10),
        Container(
          height: 1.5, // ปรับความสูงเพื่อเปลี่ยนความหนาของเส้น
          color: Color.fromARGB(255, 131, 130, 130), // สีของเส้น
        ), // เพิ่มเส้
      ],
    );
  },
)

    );
  }
}


class DirectMessage {
  
  final String userId;
  final String username;
  final String shopname;
  final String userImage;
  final String senderId;
  final String receiverId;

  DirectMessage({
    required this.userId,
    required this.username,
    required this.shopname,
    required this.userImage,
    required this.senderId,
    required this.receiverId,
  });
}
