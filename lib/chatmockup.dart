import 'package:flutter/material.dart';

class ChatMockup extends StatelessWidget {
  const ChatMockup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Mockup'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(message.sender.substring(0, 1)),
                  ),
                  title: Text(message.sender),
                  subtitle: Text(message.text),
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  static final List<Message> _messages = [
    Message(sender: 'Alice', text: 'Hi there!'),
    Message(sender: 'Bob', text: 'Hey, what\'s up?'),
    Message(sender: 'Alice', text: 'Not much, how about you?'),
    Message(sender: 'Bob', text: 'Just hanging out. Did you watch the game last night?'),
    Message(sender: 'Alice', text: 'No, I missed it. Who won?'),
    Message(sender: 'Bob', text: 'The Bears. It was a great game.'),
  ];
}

class Message {
  final String sender;
  final String text;

  const Message({required this.sender, required this.text});
}
