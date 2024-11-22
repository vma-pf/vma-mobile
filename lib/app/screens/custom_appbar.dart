import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/core/models/notification.dart' as models;

AppBar customAppBar(
  BuildContext context,
  String title, {
  Color titleColor = Colors.black,
  List<models.Notification> notifications = const [],
}) {
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
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.gear_alt_fill,
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
                    CupertinoIcons.person,
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
                    'Chào, John Doe',
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
