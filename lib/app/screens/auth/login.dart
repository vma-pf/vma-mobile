import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/screens/auth/change-password.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/network/app_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  @override
  initState() {
    _passwordVisible = false;
  }

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
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 222, 235, 231),
            Color.fromARGB(255, 40, 211, 92),
          ],
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(height: 0),
                  Column(
                    children: [
                      SizedBox(
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/vma-logo.png',
                                fit: BoxFit.contain)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Tài khoản đăng nhập',
                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 226, 218, 218),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 226, 218, 218),
                            ),
                          ),
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
                        obscureText: !_passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 226, 218, 218),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 226, 218, 218),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 226, 218, 218),
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập đủ thông tin';
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
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: const Text("Đăng nhập"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ChangePassword()));
                          });
                        },
                        child: const Text(
                          "Bạn quên mật khẩu ?",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "vma-pf@2024",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ), /* add child content here */
      ),
    );
  }
}
