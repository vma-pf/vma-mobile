import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';

class WarningScreen extends StatefulWidget {
  const WarningScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WarningScreenState();
}

class _WarningScreenState extends VMAState<WarningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Warning'),
      ),
    );
  }
}
