import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("N-Connect", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
      ),
      body: ListView(
        children:  <Widget>[
          ListTile(
            leading: const CircleAvatar(child: Text('A')),
            title: const Text('Headline'),
            subtitle: const Text('Supporting text'),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: (){
              Navigator.pushNamed(context, '/chat');
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
            subtitle: Text('Supporting text'),
            trailing: Icon(Icons.arrow_circle_right_outlined),
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
            subtitle: Text('Supporting text'),
            trailing: Icon(Icons.arrow_circle_right_outlined),
          ),
          Divider(height: 0),
          
        ]
      )
    );
  }
}