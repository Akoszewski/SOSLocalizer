import 'dart:core';
import 'dart:async';
import 'dart:io';

void startServer() {
  Future<ServerSocket> serverFuture =
      ServerSocket.bind(InternetAddress.anyIPv4, 4567);
  serverFuture.then((ServerSocket server) {
    server.listen((Socket socket) {
      socket.listen((List<int> data) {
        String result = new String.fromCharCodes(data);
        print(result.substring(0, result.length));
      });
    });
  });
}

void main() {
  startServer();
}
