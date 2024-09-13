import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/constants/route_constant.dart';
import 'package:vma/network/app_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _login() async {
    try {
      AppStorage().write("token", "123");
      context.go(RouteConstant.home);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Login Page'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                  // suffixIcon: Icon(Icons.remove_red_eye),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              ElevatedButton(onPressed: _login, child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}
