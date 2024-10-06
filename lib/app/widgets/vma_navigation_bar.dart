import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/layout.dart';

class VMANavigationBar extends StatefulWidget {
  final Function(int) onTabSelected;
  final List<NavigationItem> items;

  const VMANavigationBar({
    super.key,
    required this.onTabSelected,
    required this.items,
  });

  @override
  State<StatefulWidget> createState() => _VMANavigationBarState();
}

class _VMANavigationBarState extends VMAState<VMANavigationBar> {
  int _selectedTabIndex = 0;

  void _changeTab(int tabIndex) {
    if (tabIndex == _selectedTabIndex) return;
    setState(() {
      _selectedTabIndex = tabIndex;
    });
    widget.onTabSelected(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(5, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          items: widget.items
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.title,
                  backgroundColor: Colors.transparent,
                ),
              )
              .toList(),
          currentIndex: _selectedTabIndex,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          onTap: _changeTab,
          unselectedItemColor: Colors.grey[400],
        ),
      ),
    );
  }
}
