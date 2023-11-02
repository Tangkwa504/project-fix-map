
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../model/chat.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String chatName;
  final String senderId;
  final String image;

  const ChatScreen({
    Key? key,
    required this.receiverId,
    required this.senderId,
    required this.chatName,
    required this.image,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;



  bool showDate = false;
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];
  List<Chat> chatHistory = [];
  int showDateIndex = 0;
  List list = [];
  String room = "";
  String sender = "";
  String receiver = "";
  List msg = [];

  @override
  void initState() {
    sender = widget.senderId;
    receiver = widget.receiverId;
    getroom();
    print("widget.receiverId === " + widget.receiverId);
    print("widget.senderId === " + widget.senderId);

    super.initState();
  }
  

  void createroom(){
      String pathuser = "User/${widget.senderId}/chat";
      String pathpharmacy ="Pharmacy/${widget.receiverId}/chat";
      
      DatabaseReference refuser = FirebaseDatabase.instance.ref(pathuser);
      DatabaseReference refpharmacy = FirebaseDatabase.instance.ref(pathpharmacy);
      String newroom ="room"+"${widget.senderId}"+"-&-"+"${widget.receiverId}";
      DatabaseReference createdroom = FirebaseDatabase.instance.ref("chatroom/$newroom/message/${msg.length}");
      createdroom.set({
      "msg": "นี่คือข้อความอัตโนมัติจากร้าน "+widget.chatName,
      "sender": widget.receiverId,
      "receiver": widget.senderId,
      "time": 1694937735,
    });
      refuser.update({
        "$receiver": newroom ,
      //"chat":[{"${widget.receiverId}":"${newroom}"}]

      });
      refpharmacy.update({
        "$sender": newroom ,
        //"chat":[{"${widget.senderId}":"${newroom}"}]

      });
       
      
     room = newroom;
     setState(() {});
     getroom();

  }
  void getroom() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('User/${widget.senderId}/chat/${widget.receiverId}');
    starCountRef.onValue.listen((DatabaseEvent event) {
      print(event.snapshot.value);
      String checkroom = "${event.snapshot.value.toString()}";
      if(checkroom == "null"){
        createroom();
      }else{
      room = event.snapshot.value.toString();

      getmsg();
      }
      // room = event.snapshot.value.toString();

      // getmsg();
    });
  }
  

  void getmsg() {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('chatroom/$room/message');
    starCountRef.onValue.listen((DatabaseEvent event) {
      print("event getmsg"+"${event.snapshot.value}");
      msg = event.snapshot.value as List;
      print("List ${msg}");
      setState(() {});
    });
  }

  void sendMesg() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("chatroom/$room/message/${msg.length}");
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    await ref.set({
      "msg": messageController.text,
      "sender": widget.senderId,
      "receiver": widget.receiverId,
      "time": currentTimeMillis
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
        ),
        title: Row(
          children: [
            if (widget.image == '') ...[
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 22,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ] else ...[],
            const SizedBox(
              width: 15,
            ),
            Text(
              ' ${widget.chatName}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              // ตอนที่ปุ่มถูกคลิก
              // เพิ่มโค้ดที่คุณต้องการให้มันทำอะไรเมื่อปุ่มถูกคลิกที่นี่
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: msg.length,
                  itemBuilder: (context, index) {
                    int messageTimeMillis = msg[index]['time'];
                    DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(messageTimeMillis);
                    String formattedTime = DateFormat('HH:mm').format(messageTime);
                    String formattedDate = DateFormat('dd/MM/yyyy').format(messageTime);

                    String previousDate = '';
                    if (index > 0) {
                      int previousMessageTimeMillis = msg[index - 1]['time'];
                      DateTime previousMessageTime = DateTime.fromMillisecondsSinceEpoch(previousMessageTimeMillis);
                      previousDate = DateFormat('dd/MM/yyyy').format(previousMessageTime);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: msg[index]['sender'] == sender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (formattedDate != previousDate) ...[
                            Center(
                              child: Text(
                                formattedDate,
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                          Container(
                            decoration: BoxDecoration(
                              color: msg[index]['sender'] == sender ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${msg[index]['msg']}",
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Enter a message',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMesg();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

