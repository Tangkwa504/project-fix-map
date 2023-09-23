

import 'package:cloud_firestore/cloud_firestore.dart';
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

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getroom();
    print("widget.receiverId === "+widget.receiverId);
    print("widget.senderId === "+widget.senderId);
    super.initState();
    // connectSocket();
    // loadChatHistory();
    
  }

// void createroom(){
//   if(room = null){

//   }else{
//     getroom();
//   }
// }
void getroom(){
DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User/${widget.senderId}/chat/${widget.receiverId}');
starCountRef.onValue.listen((DatabaseEvent event){
print(event.snapshot.value);
room = event.snapshot.value.toString();
getmsg();
});
}


String room = "";
List msg = [];
void getmsg(){
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('chatroom/$room/message');
  starCountRef.onValue.listen((DatabaseEvent event) {
  print(event.snapshot.value);
  msg = event.snapshot.value as List;
  setState(() {
    
  });
   });
}

 void sendMesg() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("chatroom/$room/message/${msg.length}");

  await ref.set({
    
       "msg": messageController.text,
       "sender": widget.senderId,
       "receiverId":widget.receiverId,
       "time": 1694937735,

  
    });
     messageController.clear();
  }


















  Future<void> loadChatHistory() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference chatHistoryCollection = firestore.collection('chat_history');

    try {
      QuerySnapshot querySnapshot = await chatHistoryCollection.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data['senderId'] != null && data['receiverId'] != null) {
          Timestamp timestamp = data['timestamp'];
          DateTime date = timestamp.toDate();
          DateTime utc = date.toUtc();
          String iso = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").format(utc);
          Chat chat = Chat(
            senderId: data['senderId'],
            receiverId: data['receiverId'],
            message: data['message'],
            timestamp: DateTime.parse(iso),
          );
          chatHistory.add(chat);
        }
      }
      chatHistory.forEach((element) {
        print(element.message);
        print(element.receiverId);
        print(element.senderId);
        print(element.timestamp);
      });
      setState(() {});
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  void connectSocket() {
    socket = IO.io('http://192.168.1.3:3000',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
        });
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('message', (data) {
      setState(() {
        chatMessages.clear();
        //chatMessages.add(data['message']);
        print("datamessage ==== "+data);
      });
    });
    socket.connect();
  }

  void sendMessage(String message) {
    socket.emit('sendmessage', {
      'senderId': widget.senderId,
      'receiverId': widget.receiverId,
      'message': message,
    });

    // setState(() {
    //   loadChatHistory();
    //   showDateIndex = 0;
    //   showDate = false;
    // });
    loadChatHistory(); // เรียกใช้งานฟังก์ชันนี้เพื่ออัปเดตประวัติแชท

    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    setState(() {
    messageController.clear(); // เคลียร์ค่าในช่องข้อความ
  });
  }

  // @override
  // void dispose() {
  //   socket.disconnect();
  //   super.dispose();
  // }

  Widget itemListBuilder() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      itemCount: chatHistory.length,
      itemBuilder: (context, index) {
        final chat = chatHistory[index];
        final isSentMessage = chat.senderId == widget.senderId;
        final timeDate = chat.localTimestamp.toString();

        final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
        final outputFormat = DateFormat("HH:mm 'น.'");

        final parsedDate = inputFormat.parse(timeDate);
        final formattedDate = outputFormat.format(parsedDate);

        return Container(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: isSentMessage ? Alignment.topRight : Alignment.topLeft,
            child: InkWell(
              onTap: () {
                setState(() {
                  showDate = !showDate;
                  showDateIndex = index;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showDate && index == showDateIndex)
                    Container(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isSentMessage ? Colors.blue : Color.fromARGB(255, 168, 192, 168),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      chat.message,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
          decoration: const BoxDecoration(

          ),
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
            ] else ...[

            ],
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
      ),
      body: Column(
        children: [
          Expanded(
            child: itemListBuilder(),
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
    );
  }
}

