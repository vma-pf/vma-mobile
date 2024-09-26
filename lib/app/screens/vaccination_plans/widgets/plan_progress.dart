import 'package:flutter/material.dart';

class PlanProgress extends StatelessWidget {
  final int _maxLength = 200;
  final double percentage;
  final String text;

  @override
  const PlanProgress({super.key, required this.percentage, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 3),
        Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: SizedBox(width: _maxLength.toDouble(), height: 10),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(width: _maxLength * percentage, height: 10),
            ),
          ],
        )
      ],
    );
  }
}
