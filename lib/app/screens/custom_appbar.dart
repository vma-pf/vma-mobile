import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primaryFixed,
    // centerTitle: true,
    title: const Text(
      'Dashboard',
      style: TextStyle(
        fontSize: 22,
        // color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.53,
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(60),
      ),
    ),
    // leading: InkWell(
    //   onTap: () {},
    //   child: const Icon(
    //     Icons.subject,
    //   ),
    // ),
    actions: [
      InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.bell_fill,
          ),
        ),
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
