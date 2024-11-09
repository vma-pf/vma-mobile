import 'package:flutter/material.dart';

class PigVaccinationItem extends StatelessWidget {
  final String pigCode;
  final bool isCheked;
  final Function(bool?) onChanged;

  const PigVaccinationItem({
    super.key,
    this.isCheked = false,
    required this.onChanged,
    required this.pigCode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: isCheked, onChanged: onChanged),
        Expanded(
          child: Text(pigCode),
        ),
      ],
    );
  }
}
