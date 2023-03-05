import 'package:flutter/material.dart';

class Chatroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatroom'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ChatBubble(
                  message: 'Hello world!',
                  isMe: index % 2 == 0, 
                  photoUrl: 'https://example.com/avatar.jpg',
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a message',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String photoUrl;

  ChatBubble({required this.message, required this.isMe, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        !isMe ? 
        CircleAvatar(
          backgroundImage: NetworkImage(photoUrl),
        ) : Container(),
        Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[200],
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
        isMe ?
        CircleAvatar(
          backgroundImage: NetworkImage(photoUrl),
        ) : Container(),
      ],
    );
  }
}
