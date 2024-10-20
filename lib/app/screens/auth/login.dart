import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/auth/widgets/wave_background.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/log_in_event.dart';
import 'package:vma/core/view_models/authentication_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends VMAState<Login> {
  final AuthenticationModel _model = AuthenticationModel();

  @override
  initState() {
    super.initState();
    EventManager.register<LoginEvent>(_handleLoginEvent);
  }

  @override
  void dispose() {
    EventManager.unregister(LoginEvent);
    super.dispose();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  final gradient =
      const LinearGradient(colors: [Colors.indigoAccent, Colors.tealAccent]);

  void _handleLoginEvent(LoginEvent event) {
    if (event.loginSuccess) {
      context.go(Routes.home);
      showSuccessSnackBar('Đăng nhập thành công');
    } else {
      showFailureSnackBar(
        'Đăng nhập thất bại, vui lòng kiểm tra lại thông tin',
      );
    }
  }

  void _login() async {
    try {
      startLoading();
      await _model.login(
        _usernameController.text,
        _passwordController.text,
      );
    } catch (e) {
      // TODO: log error
      showFailureSnackBar('Đã có lỗi xảy ra, vui lòng thử lại sau');
    } finally {
      stopLoading();
    }
  }

  Icon _getIconBasedOnPasswordVisisbility() {
    final visibilityIcon =
        _isPasswordVisible ? Icons.visibility_off : Icons.visibility;
    return Icon(visibilityIcon);
  }

  void _changePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  String? Function(String?) _requiredValueValidator(String errorMessage) {
    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    }

    return validator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                        ),
                        validator: _requiredValueValidator(
                          'Vui lòng nhập tên đăng nhập',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'johndoe@123',
                          label: const Text('Nhập mật khẩu'),
                          border: const OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          suffixIcon: GestureDetector(
                            onTap: _changePasswordVisibility,
                            child: _getIconBasedOnPasswordVisisbility(),
                          ),
                        ),
                        validator:
                            _requiredValueValidator('Vui lòng nhập mật khẩu'),
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
