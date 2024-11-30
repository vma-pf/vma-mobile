import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/herds/screen.dart';
import 'package:vma/app/screens/home/widgets/navigation_item.dart';
import 'package:vma/app/screens/medicine_requests/screen.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends VMAState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            NavigationItem(
              destination: const HerdsScreen(),
              assetPath: 'assets/images/pig.png',
              text: 'Danh sách heo',
              backgroundColor: Colors.green.withOpacity(0.8),
              textColor: Colors.white,
            ),
            NavigationItem(
              destination: const MedicineRequestsScreen(),
              assetPath: 'assets/images/medicine.png',
              text: 'Yêu cầu xuất thuốc',
              backgroundColor: Colors.blue.withOpacity(0.8),
              textColor: Colors.white,
            ),
            NavigationItem(
              destination: const CommonDiseaseAndTreatmentGuideScreen(),
              assetPath: 'assets/images/vaccination.png',
              text: 'Thông tin điều trị',
              backgroundColor: Colors.blue.withOpacity(0.8),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
