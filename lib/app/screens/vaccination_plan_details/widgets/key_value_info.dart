import 'package:flutter/cupertino.dart';

class KeyValueInfo extends StatelessWidget {
  final String label;
  final String content;

  const KeyValueInfo({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.3,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.6,
            child: Text(content, softWrap: true, overflow: TextOverflow.clip),
          ),
        ],
      ),
    );
  }
}
