import 'package:flutter/material.dart';

class RequestStatus extends StatelessWidget {
  final String status;

  const RequestStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return const Text('request.status');
  }
}
