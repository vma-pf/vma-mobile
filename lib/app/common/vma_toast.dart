import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vma/app/common/toast_type.dart';

class VMAToast {
  static final FToast _fToast = FToast();

  static void init(BuildContext context) {
    if (_fToast.context != null) {
      return;
    }
    _fToast.init(context);
  }

  static void finalize() {
    _fToast.context = null;
  }

  static void show(String message, ToastType type) {
    Color textColor = Colors.grey;
    Icon icon = const Icon(Icons.info, weight: 900);

    switch (type) {
      case ToastType.success:
        textColor = Colors.greenAccent;
        icon = const Icon(Icons.check, color: Colors.greenAccent);
        break;
      case ToastType.error:
        textColor = Colors.red;
        icon = const Icon(Icons.error, color: Colors.red);
        break;
      case ToastType.warning:
        textColor = Colors.orange;
        icon = const Icon(Icons.warning, color: Colors.orange);
        break;
      case ToastType.info:
        textColor = Colors.blue;
        icon = const Icon(Icons.info, color: Colors.blue);
        break;
    }

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 2),
    );
  }

  static void showSuccess(String message) {
    show(message, ToastType.success);
  }

  static void showError(String message) {
    show(message, ToastType.error);
  }

  static void showWarning(String message) {
    show(message, ToastType.warning);
  }

  static void showInfo(String message) {
    show(message, ToastType.info);
  }
}
