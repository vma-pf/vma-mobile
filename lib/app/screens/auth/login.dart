import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/network/app_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _login() async {
    try {
      AppStorage().write("token", "123");
      context.go(Routes.home);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/login_screen.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/vma-logo.png',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 341,
                  ),
                  const Text('Login Page'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Tài khoản đăng nhập'),
                      border: OutlineInputBorder(),
                      // suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập đủ thông tin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      label: const Text('Mật khẩu'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: const Text("Đăng nhập"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), /* add child content here */
      ),
    );
  }
}
