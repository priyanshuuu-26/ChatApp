import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/message.dart';
import 'socket_provider.dart';

class ChatNotifier extends StateNotifier<List<Message>> {
  final Ref _ref;
  final String _currentUserId;

  ChatNotifier(this._ref, this._currentUserId) : super([]) {
    _init();
  }

  void _init() {
    _ref.read(socketProvider).on('receiveMessage', (data) {
      final message = Message(
        id: const Uuid().v4(),
        senderId: data['senderId'],
        text: data['message'],
        timestamp: DateTime.now(),
      );
      state = [...state, message];
    });
  }
  void sendMessage(String text, String recipientId) {
    final message = Message(
      id: const Uuid().v4(),
      senderId: _currentUserId, 
      text: text,
      timestamp: DateTime.now(),
    );
    state = [...state, message];
    _ref.read(socketProvider).emit('sendMessage', {
      'recipientId': recipientId,
      'message': text,
    });
  }

  @override
  void dispose() {
    _ref.read(socketProvider).off('receiveMessage');
    super.dispose();
  }
}
final chatProvider = StateNotifierProvider.family<ChatNotifier, List<Message>, String>(
  (ref, currentUserId) {
    return ChatNotifier(ref, currentUserId);
  },
);