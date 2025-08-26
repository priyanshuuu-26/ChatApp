import 'package:chat_app/pallete.dart';
import 'package:chat_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/socket_provider.dart';

final currentUserIdProvider = StateProvider<String?>((ref) => null);

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _controller = TextEditingController();

  void _joinChat() {
    if (_controller.text.trim().isNotEmpty) {
      final username = _controller.text.trim();
      ref.read(currentUserIdProvider.notifier).state = username;
      ref.read(socketProvider).disconnect();
      ref.read(socketProvider).io.options?['query'] = {'userId': username};
      ref.read(socketProvider).connect();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ContactsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to ChatApp',style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),),
        backgroundColor: Pallete.backgroundColor,
        centerTitle: true,
      ),
      backgroundColor: Pallete.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _joinChat,
                child: const Text('Join Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
