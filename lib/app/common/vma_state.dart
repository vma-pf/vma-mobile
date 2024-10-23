import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_toast.dart';

class VMAState<T extends StatefulWidget> extends State<T> {
  bool isScreenLoading = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }

    VMAToast.init(context);
  }

  @override
  void dispose() {
    VMAToast.finalize();
    super.dispose();
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

  void startLoading() {
    this.setState(() => isScreenLoading = true);
  }

  void stopLoading() {
    this.setState(() => isScreenLoading = true);
  }
}
