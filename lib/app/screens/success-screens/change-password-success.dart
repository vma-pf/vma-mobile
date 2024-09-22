import 'package:flutter/material.dart';
import 'package:vma/app/screens/auth/login.dart';

class ChangePasswordSuccess extends StatefulWidget {
  const ChangePasswordSuccess({super.key});

  @override
  _ChangePasswordSuccessState createState() => _ChangePasswordSuccessState();
}

class _ChangePasswordSuccessState extends State<ChangePasswordSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 222, 235, 231),
            Color.fromARGB(255, 40, 211, 92),
          ],
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 100,
              child: Image.asset('assets/images/icons/pig-happy.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Đổi mật khẩu thành công!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  });
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text("Quay về đăng nhập"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
