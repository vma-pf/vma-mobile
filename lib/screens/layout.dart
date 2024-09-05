import 'package:flutter/material.dart';
import 'package:vma/screens/alert.dart';
import 'package:vma/screens/camera.dart';
import 'package:vma/screens/foo_screen.dart';
import 'package:vma/screens/home.dart';
import 'package:vma/screens/treatment_plan.dart';
import 'package:vma/screens/vaccination.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

List<IconData> _icons = [
  Icons.poll,
  Icons.medical_services,
  Icons.local_hospital,
  Icons.camera_alt,
  Icons.warning,
];

List<String> _titles = [
  'Tổng quan',
  'Tiêm phòng',
  'Điều trị',
  'Camera',
  "Cảnh báo",
];

int _isSelectedIndex = 0;

class _LayoutPageState extends State<LayoutPage> {
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(title: "Hello, World!"),
    Vaccination(),
    TreatmentPlan(),
    Camera(),
    Alert(),
  ];

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)!.settings.name!;
    print(currentRoute);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("VMA"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FooScreen()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        children: [
          _widgetOptions.elementAt(_isSelectedIndex),
          Align(
            alignment: Alignment.bottomCenter,
            child: _navBar(),
          ),
        ],
      ),
    );
  }

  Widget _navBar() {
    return Container(
        height: 60,
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          verticalDirection: VerticalDirection.down,
          textDirection: TextDirection.ltr,
          children: _icons.map(
            (icon) {
              int index = _icons.indexOf(icon);
              bool isSelected = _icons.indexOf(icon) == _isSelectedIndex;
              return Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => setState(() {
                    _isSelectedIndex = index;
                  }),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 0, left: 20, right: 20),
                          child: Icon(icon,
                              color: isSelected
                                  ? Colors.teal[300]
                                  : Colors.grey[600]),
                        ),
                        isSelected
                            ? Text(
                                _titles[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.teal[300]
                                      : Colors.grey[600],
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                        // const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ));
  }
}
