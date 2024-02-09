import 'package:flutter/material.dart';

import 'package:g_solution/screens/businesses_dashboard.dart';
import 'package:g_solution/screens/business_products.dart';
import 'package:g_solution/screens/business_profile.dart';

class BottomNavbarWidget extends StatefulWidget {

  final List<Widget>? menuScreens;
  final List<BottomNavigationBarItem>? menuItems;

  BottomNavbarWidget({
    super.key,
    this.menuScreens,
    this.menuItems,
  });

  @override
  State<BottomNavbarWidget> createState() =>
      _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbarWidget> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Initialize _widgetOptions based on menu_screens or use a default value
    _widgetOptions = widget.menuScreens ?? <Widget>[];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.menuItems ?? <BottomNavigationBarItem>[],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
