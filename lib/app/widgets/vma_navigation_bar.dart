import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/layout.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/main_screen_index_changed_event.dart';

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
  void initState() {
    super.initState();
    EventManager.register(_handleIndexChanged);
  }

  @override
  void dispose() {
    EventManager.unregister(MainScreenIndexChangedEvent);
    super.dispose();
  }

  void _handleIndexChanged(MainScreenIndexChangedEvent event) {
    _changeTab(event.index);
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.elliptical(60, 35),
      topRight: Radius.elliptical(60, 35),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
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
        borderRadius: borderRadius,
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          items: widget.items
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(item.icon),
                  ),
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
