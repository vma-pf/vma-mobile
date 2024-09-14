import 'package:flutter/material.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({super.key});

  @override
  State<Vaccination> createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Vaccination"),
    );
  }
}
