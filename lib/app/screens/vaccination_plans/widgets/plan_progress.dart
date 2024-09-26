import 'package:flutter/material.dart';

class PlanProgress extends StatelessWidget {
  final int _maxLength = 200;
  final double percentage;
  final DateTime startDate;
  final DateTime endDate;
  final String text;

  @override
  const PlanProgress({
    super.key,
    required this.percentage,
    required this.startDate,
    required this.endDate,
    required this.text,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

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
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(width: _maxLength.toDouble(), height: 10),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(width: _maxLength * percentage, height: 10),
            ),
          ],
        ),
        SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(startDate),
                style: const TextStyle(fontSize: 10),
              ),
              Text(
                _formatDate(endDate),
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
