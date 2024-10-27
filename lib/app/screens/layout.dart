import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_toast.dart';
import 'package:vma/app/screens/management/home.dart';
import 'package:vma/app/screens/medicine_requests/screen.dart';
import 'package:vma/app/screens/pig_list/screen.dart';
import 'package:vma/app/screens/vaccination_plans/screen.dart';
import 'package:vma/app/screens/vaccination_schedules/screen.dart';
import 'package:vma/app/widgets/vma_navigation_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

int _isSelectedIndex = 0;

class _LayoutPageState extends State<LayoutPage> {
  @override
  void initState() {
    super.initState();
    VMAToast.init(context);
  }

  static final List<NavigationItem> _navigationItems = <NavigationItem>[
    NavigationItem(
      icon: CupertinoIcons.chart_bar_fill,
      title: 'Tổng quan',
      screen: const MyHomePage(title: "Hello, World!"),
    ),
    // NavigationItem(
    //   icon: Icons.medical_services,
    //   title: 'Tiêm phòng',
    //   screen: const Vaccination(),
    // ),
    NavigationItem(
      icon: Icons.medical_services,
      title: 'Tiêm phòng',
      screen: const MedicineRequestsScreen(),
    ),
    // NavigationItem(
    //   icon: CupertinoIcons.calendar,
    //   title: 'Điều trị',
    //   screen: const PigDetail(pigId: '1cb82ddc-21d6-4253-9a61-5cec43d024cf'),
    // ),
    NavigationItem(
      icon: CupertinoIcons.calendar,
      title: 'Điều trị',
      screen: const VaccinationSchedule(),
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
        herdId: 'd869bc09-7e82-4b2a-acaa-cb3b5c9332e7',
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
