import 'package:flutter/material.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({super.key});

  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Vaccination"),
    );
  }
}
