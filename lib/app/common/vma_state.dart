import 'package:flutter/material.dart';

class VMAState<T extends StatefulWidget> extends State<T> {
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
    return finalWidget;
  }
}
