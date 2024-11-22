import 'package:flutter/material.dart';

class Cage extends StatelessWidget {
  final Function onTap;
  final String cageCode;

  const Cage({
    super.key,
    required this.onTap,
    required this.cageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: InkWell(
          onTap: () => onTap(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cageCode,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Image.asset(
                'assets/images/camera.png',
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
