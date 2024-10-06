import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/screens/management/home.dart';
import 'package:vma/app/screens/management/vaccination.dart';
import 'package:vma/app/screens/pig_detail/screen.dart';
import 'package:vma/app/screens/pig_list/screen.dart';
import 'package:vma/app/screens/vaccination_plans/screen.dart';
import 'package:vma/app/widgets/vma_navigation_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

int _isSelectedIndex = 0;

class _LayoutPageState extends State<LayoutPage> {
  static final List<NavigationItem> _navigationItems = <NavigationItem>[
    NavigationItem(
      icon: CupertinoIcons.chart_bar_fill,
      title: 'Tổng quan',
      screen: const MyHomePage(title: "Hello, World!"),
    ),
    NavigationItem(
      icon: Icons.medical_services,
      title: 'Tiêm phòng',
      screen: const Vaccination(),
    ),
    NavigationItem(
      icon: CupertinoIcons.calendar,
      title: 'Điều trị',
      screen: const PigDetail(pigId: '1cb82ddc-21d6-4253-9a61-5cec43d024cf'),
    ),
    NavigationItem(
      icon: CupertinoIcons.video_camera_solid,
      title: 'Camera',
      screen: const PigList(),
    ),
    NavigationItem(
      icon: CupertinoIcons.bell_fill,
      title: 'Cảnh báo',
      screen: const VaccinationPlans(
        herdId: '31c334fc-308a-40a9-a058-21bc4c4a3da0',
      ),
    ),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _isSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationItems[_isSelectedIndex].screen,
      bottomNavigationBar: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme,
          highlightColor: Colors.transparent,
        ),
        child: VMANavigationBar(
          items: _navigationItems,
          onTabSelected: _onTabSelected,
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String title;
  final Widget screen;

  NavigationItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}
