import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
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
        icon: Icon(CupertinoIcons.bell_fill),
        // onSelected: (value) {
        //   // Handle selected notification
        //   print("Selected: $value");
        // },
        itemBuilder: (BuildContext context) {
          return List.generate(notifications.length, (index) {
            return PopupMenuItem<int>(
              value: index,
              child: Text(notifications[index].title),
            );
          });
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
