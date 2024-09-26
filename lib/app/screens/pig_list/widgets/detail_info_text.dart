import 'package:flutter/material.dart';

class DetailInfoText extends StatelessWidget {
  final String label;
  final Object data;

  const DetailInfoText({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '$label: ', style: const TextStyle(fontSize: 12)),
          TextSpan(
            text: data.toString(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
