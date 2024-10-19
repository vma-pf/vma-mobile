import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/screens/auth/widgets/wave_background.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/network/app_storage.dart';
import 'package:vma/core/view_models/authentication_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _formkey = GlobalKey<FormState>();
  final AuthenticationModel _model = AuthenticationModel();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final gradient = const LinearGradient(
    colors: [Colors.indigoAccent, Colors.tealAccent],
  );
  bool isVisible = false;
  bool isLoading = false;

  void _login() async {
    try {
      isLoading = true;
      await _model.login(
        _usernameController.text,
        _passwordController.text,
      );
      print('login success');
      // context.go(Routes.home);
    } catch (e) {
      // print(e);
    } finally {
      isLoading = false;
    }
  }

  // void _login() async {
  //   try {
  //     isLoading = true;
  //     AppStorage().write("token", "123");
  //     context.go(Routes.home);
  //     isLoading = false;
  //   } catch (e) {
  //     // print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // CustomPaint(
          //   painter: WavePainter(),
          //   child: Container(
          //     height: 250,
          //   ),
          // ),
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CustomPaint(
                  painter: WavePainter(),
                  child: Container(
                    height: 250,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.rotate(
                  angle: pi,
                  child: CustomPaint(
                    painter: WavePainter(),
                    child: Container(
                      height: 250,
                    ),
                  ),
                ),
              ),
              // Other widgets...
            ],
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/vma-logo.png',
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Đăng nhập vào tài khoản của bạn',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'johndoe123',
                          label: const Text('Nhập tên đăng nhập'),
                          border: const OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          // suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          hintText: 'johndoe@123',
                          label: const Text('Nhập mật khẩu'),
                          border: const OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Icon(
                              isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
