import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../model/chat.dart';
import '../widgets/Service.dart';

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

  bool showDate = false; // Variable to track the display of the date

  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];
  List<Chat> chatHistory = [];
  int showDateIndex = 0;
  @override
  void initState() {
    super.initState();
    connectSocket();
    loadChatHistory();
  }
  

  Future<void> loadChatHistory() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference chatHistoryCollection = firestore.collection('chat_history');

  try {
    QuerySnapshot querySnapshot = await chatHistoryCollection.get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // ตรวจสอบคู่ค่า senderId และ receiverId และเพิ่มลงใน chatHistory
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
          //timestamp: DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(timestamp.toDate().toIso8601String()),
          // อื่น ๆ ที่คุณต้องการใส่ลงใน Chat object data['timestamp']  DateTime.parse(timestamp.toDate().toString())
          
        );
        print(DateTime.timestamp());
        print("DateTime = "+date.toString());
        print("datasenderId = "+data['senderId']);
        print("datareceiverId = "+data['receiverId']);
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
    socket.on('chat message', (data) {
      setState(() {
        chatMessages.add(data['message']);
      });
    });
    socket.connect();
  }

  void sendMessage(String message) {
    socket.emit('message', {
      'senderId': widget.senderId,
      'receiverId': widget.receiverId,
      'message': message,
    });

    setState(() {
      loadChatHistory();
      showDateIndex = 0;
      showDate = false;
    });
    messageController.clear();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
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
            child: ListView.builder(
              reverse: true, // เพื่อให้เรียงลำดับจากล่าสุดไปยังเก่าสุด
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                final chat = chatHistory[index];
                final isSentMessage = chat.senderId == widget.senderId;//เช็คId ผู้ส่ง
                final timeDate = chat.localTimestamp.toString();

                final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
                final outputFormat = DateFormat("HH:mm 'น.'");

                final parsedDate = inputFormat.parse(timeDate);
                final formattedDate = outputFormat.format(parsedDate);

                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (isSentMessage
                        ? Alignment.topRight//true ชิดขวา
                        : Alignment.topLeft),//ไม่ใช่ ชิดซ้าย
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
                              //margin: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
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
                    sendMessage(messageController.text);
                    messageController.clear();
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