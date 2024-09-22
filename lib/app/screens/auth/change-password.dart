import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/screens/success-screens/change-password-success.dart';
import 'package:vma/core/constants/routes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  void _changePassword() async {
    try {
      // context.go(Routes.changePasswordSuccess);
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChangePasswordSuccess()));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Color(0xFF393939),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu mới',
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
                  style: const TextStyle(
                    color: Color(0xFF393939),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      _changePassword();
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const Text("Đổi mật khẩu"),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
