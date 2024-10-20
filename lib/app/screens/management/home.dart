import 'package:flutter/material.dart';
import 'package:vma/app/screens/custom_appbar.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
import 'package:vma/core/network/app_storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                AppStorage.delete(AppStorageKeys.token);
                context.go(Routes.login);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
