import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/common/app_router.dart';
import 'package:vma/core/network/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeNotification();
  await Firebase.initializeApp();
  await _requestNotiPermission();
  runApp(const MyApp());
}

Future<void> _requestNotiPermission() async {
  final NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    return;
  }

  final String? token = await FirebaseMessaging.instance.getToken();
  final body = {'tokenDevice': token};
  ApiCaller.instance.request(
    path: '/api/notification/token-device',
    method: ApiMethod.post,
    data: body,
  );
}

void _initializeNotification() {
  AwesomeNotifications().initialize(
    null,
    // set the icon to null if you want to use the default app icon
    // 'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      ),
    ],
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VMA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff10b981)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
