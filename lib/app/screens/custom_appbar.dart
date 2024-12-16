import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/notification_received_event.dart';
import 'package:vma/core/models/notification.dart' as models;
import 'package:vma/core/network/app_storage.dart';

AppBar customAppBar(
  BuildContext context,
  String title, {
  Color titleColor = Colors.black,
  List<models.Notification> notifications = const [],
}) {
  void handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                AppStorage.delete(AppStorageKeys.token);
                context.go(Routes.login);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }

  String getTimePassed(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primaryFixed,
    title: Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(60),
      ),
    ),
    actions: [
      PopupMenuButton<int>(
        color: Colors.white,
        icon: Icon(CupertinoIcons.bell_fill),
        onOpened: () {
          EventManager.fire(NotificationReceivedEvent());
        },
        itemBuilder: (BuildContext context) {
          if (notifications.isEmpty) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Center(
                  child: Text('Không có thông báo mới'),
                ),
              ),
            ];
          }

          return List.generate(
            notifications.length,
            (index) {
              final noti = notifications[index];
              return PopupMenuItem<int>(
                value: index,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noti.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text('Nội dung: ${noti.content}'),
                    Text(
                      getTimePassed(noti.createdAt),
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
      InkWell(
        onTap: handleLogout,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.square_arrow_right,
          ),
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: Row(
          children: [
            const Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.person_fill,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xin chào bác sĩ thú y',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
