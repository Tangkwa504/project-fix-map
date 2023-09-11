
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../model/chat.dart';


// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   static const String routeName = '/chat-page';

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<Chat> chatHistory = [];
//   List<Chat> lastChatHistory = [];

//   @override
//   void initState() {
//     super.initState();
//     getAllChatHistory();
//     setState(() {});
//   }

//   Future<String> getChatName(Chat lastchat) async {
//     String chatName;
//     Store storeData;
//     UserData userdata;


//     //print(lastchat.receiverId);


//   String getTime(DateTime time) {
//     final outputFormat = DateFormat("dd/MM HH:mm 'น.'");
//     final formattedDate = outputFormat.format(time);
//     return formattedDate;
//   }

//   void changeData() {
//     setState(() {
//       getAllChatHistory();
//       setState(() {});
//     });
//   }

//   Future<void> getAllChatHistory() async {

//     setState(() {
      
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('ประวัติการแชท'),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: lastChatHistory.length,
//         itemBuilder: (context, index) => GestureDetector(
//           child: InkWell(
//             onTap: () async {
//               String chatName = '';
//               Store storeData;
//               String image = '';
//               UserData userdata;
//               final storeProvider =

//               // ignore: use_build_context_synchronously
//               final result = await Navigator.pushNamed(
//                 context,
//                 ChatScreen.routeName,
//                 arguments: {
//                   'receiverId': (lastChatHistory[index].receiverId ==
//                           userProvider.user.id)
//                       ? lastChatHistory[index].senderId
//                       : lastChatHistory[index].receiverId,
//                   'chatName': chatName,
//                   'senderId': userProvider.user.id,
//                   'image': image,
//                 },
//               );
//               if (result == true) {
//                 changeData();
//               }
//             },
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: FutureBuilder<String>(
//                     future: getChatImage(lastChatHistory[index]),
//                     builder:
//                         (BuildContext context, AsyncSnapshot<String> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         // กรณีกำลังโหลดข้อมูล
//                         return const CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         // กรณีเกิดข้อผิดพลาดในการโหลดข้อมูล
//                         return Text('Error: ${snapshot.error}');
//                       } else {
//                         final imageUrl = snapshot.data;
//                         return imageUrl == ""
//                             ? CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor: Colors.blueGrey,
//                                 child: Image.asset(
//                                   "assets/images/user.png",
//                                   color: Colors.white,
//                                   height: 30,
//                                   width: 30,
//                                 ),
//                               )
//                             : CircleAvatar(
//                                 backgroundColor: Colors.teal,
//                                 radius: 25,
//                                 child: CircleAvatar(
//                                   backgroundImage: NetworkImage(imageUrl!),
//                                   radius: 22,
//                                 ),
//                               );
//                       }
//                     },
//                   ),
//                   title: FutureBuilder<String>(
//                     future: getChatName(lastChatHistory[index]),
//                     builder:
//                         (BuildContext context, AsyncSnapshot<String> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else {
//                         return Text(
//                           snapshot.data!,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   subtitle: Row(
//                     children: [
//                       const SizedBox(
//                         width: 3,
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             lastChatHistory[index].message,
//                             style: const TextStyle(
//                               fontSize: 13,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           getTime(lastChatHistory[index].localTimestamp),
//                           style: const TextStyle(
//                             fontSize: 10,
//                           ),
//                           textAlign: TextAlign.end,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20, left: 80),
//                   child: Divider(
//                     thickness: 1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// }