import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/custom_appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends VMAState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.title),
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
          ),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pig.png',
                      height: 100,
                      width: 100,
                    ),
                    Text('Danh sách heo'),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/medicine.png',
                      height: 100,
                      width: 100,
                    ),
                    Text('Yêu cầu xuất thuốc'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
