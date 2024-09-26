import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

class DemoSignalr extends StatefulWidget {
  const DemoSignalr({super.key});

  @override
  State<StatefulWidget> createState() => _DemoSignalr();
}

class _DemoSignalr extends State<DemoSignalr> {
  late final HubConnection _connection;
  static const String _serverUrl = 'http://localhost:5000/hub';

  @override
  void initState() {
    super.initState();
    _connectToHub();
  }

  void _connectToHub() async {
    _connection = HubConnectionBuilder().withUrl(_serverUrl).build();
    await _connection.start();
    _listenToEvents();
  }

  void _listenToEvents() {
    _connection.on('ReceiveMessage', (message) {
      // Handle received message
    });
  }

  void _invokeServerMethod() async {
    await _connection.invoke('SendMessage', args: <Object>['Hello, World!']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: _invokeServerMethod,
          child: const Text('Send message'),
        ),
      ),
    );
  }
}
