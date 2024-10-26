import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

class DemoTokenScreen extends StatefulWidget {
  const DemoTokenScreen({super.key});
  @override
  State<DemoTokenScreen> createState() => _DemoTokenScreenState();
}

class _DemoTokenScreenState extends State<DemoTokenScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _getToken();
    _setupListeners();
  }

  // Request notification permissions (for iOS).
  void _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Get and print the device token.
  void _getToken() async {
    String? token = await _messaging.getToken();
    print('Device Token: $token');
  }

  // Setup listeners for notification events.
  void _setupListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(message.notification?.title ?? ''),
            content: Text(message.notification?.body ?? ''),
          );
        },
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FCM Demo')),
      body: const Center(
        child: Text('Waiting for notifications...'),
      ),
    );
  }
}
