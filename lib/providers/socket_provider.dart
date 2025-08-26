import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = Provider<IO.Socket>((ref) {
  final socket = IO.io('http://192.168.1.17:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  socket.connect();

  socket.onConnect((_) {
    print('Connected to socket server');
  });
  
  socket.onDisconnect((_) => print('Disconnected from socket server'));
  ref.onDispose(() {
    socket.dispose();
  });
  return socket;
});