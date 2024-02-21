import 'package:flutter/material.dart';

class BottomNavbarWidget extends StatefulWidget {
  final List<Widget>? menuScreens;
  final List<BottomNavigationBarItem>? menuItems;

  BottomNavbarWidget({
    Key? key,
    this.menuScreens,
    this.menuItems,
  }) : super(key: key);

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbarWidget> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.menuItems ?? <BottomNavigationBarItem>[],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Use fixed type for more than 3 items
        selectedFontSize: 14.0, // Adjust font size if needed
        unselectedFontSize: 14.0,
      ),
    );
  }
}
