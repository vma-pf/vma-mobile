// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/common/vma_toast.dart';
import 'package:vma/core/network/api.dart';

class DemoNoti extends StatefulWidget {
  const DemoNoti({super.key});

  @override
  State<StatefulWidget> createState() => _DemoNotiState();
}

class _DemoNotiState extends VMAState<DemoNoti> {
  final FirebaseMessaging _firebaseInstance = FirebaseMessaging.instance;

  Future<bool> _requestPermission() async {
    final result = await _firebaseInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    return result.authorizationStatus == AuthorizationStatus.authorized;
  }

  void _getToken() async {
    final isPermitted = await _requestPermission();
    if (!isPermitted) {
      return;
    }
    final token = await _firebaseInstance.getToken();
    final body = {'tokenDevice': token};
    ApiCaller.instance.request(
      path: '/api/notification/token-device',
      method: ApiMethod.post,
      data: body,
    );
  }

  void _initializeListeners() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: 'Hello World!',
        body: 'This is my first notification!',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    VMAToast.init(context);
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: _initializeListeners,
          child: const Text('Get token'),
        ),
      ),
    );
  }
}
