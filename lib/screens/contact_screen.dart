import 'package:chat_app/pallete.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static const List<Map<String, String>> contacts = [
    {'id': 'Aman', 'name': 'Aman'},
    {'id': 'Mudit', 'name': 'Mudit'},
    {'id': 'Priyanshu', 'name': 'Priyanshu'},
    {'id': 'Enigma', 'name': 'Enigma'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Pallete.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(child: Text(contact['name']![0])),
            title: Text(contact['name']!),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    recipientId: contact['id']!,
                    recipientName: contact['name']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
