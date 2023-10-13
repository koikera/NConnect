import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
          ),
        backgroundColor: primary
      ),
      body: Container(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              title: Text('Headline'),
              leading: Text("Teste"),
            ),
            ListTile(
              leading: Text("Teste"),
            ),
            ListTile(
              leading: Text("Teste"),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: ListTile(
            title: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: 'Escreva aqui',
              ),
            ),
            trailing: IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.send, color: textColor),
            ),
          ),
        ),
    );
  }
}