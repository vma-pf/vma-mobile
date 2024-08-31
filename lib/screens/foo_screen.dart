import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/constants/route_constant.dart';

class FooScreen extends StatelessWidget {
  const FooScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => context.go(RouteConstant.home),
            child: const Text('Go to Home Screen')),
      ),
    );
  }
}
