import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class VMAState<T extends StatefulWidget> extends State<T> {
  bool isScreenLoading = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  Widget handleAsyncSnapshot(AsyncSnapshot snapshot, Widget finalWidget) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Đã có lỗi xảy ra: ${snapshot.error}'));
    }
    if (snapshot.data == null) {
      return const Center(child: Text('Không có dữ liệu'));
    }
    return finalWidget;
  }

  void showSnackBar(String message, ContentType contentType) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: _getSnackBarTitle(contentType),
        message: message,
        contentType: contentType,
        inMaterialBanner: true,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(message, ContentType.success);
  }

  void showFailureSnackBar(String message) {
    showSnackBar(message, ContentType.failure);
  }

  void showWarningSnackBar(String message) {
    showSnackBar(message, ContentType.warning);
  }

  void showHelpSnackBar(String message) {
    showSnackBar(message, ContentType.help);
  }

  void startLoading() {
    this.setState(() => isScreenLoading = true);
  }

  void stopLoading() {
    this.setState(() => isScreenLoading = true);
  }

  String _getSnackBarTitle(ContentType contentType) {
    switch (contentType) {
      case ContentType.failure:
        return 'Error';
      case ContentType.help:
        return 'Info';
      case ContentType.success:
        return 'Success';
      case ContentType.warning:
        return 'Warning';
      default:
        return 'On Snap!';
    }
  }
}
