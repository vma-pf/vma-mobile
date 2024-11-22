import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String assetPath;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget destination;

  const NavigationItem({
    super.key,
    required this.assetPath,
    required this.text,
    this.backgroundColor,
    this.textColor,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => destination)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetPath,
                height: 100,
                width: 100,
              ),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
