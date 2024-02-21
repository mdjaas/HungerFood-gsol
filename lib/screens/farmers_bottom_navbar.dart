import 'package:flutter/material.dart';

import 'package:g_solution/widgets/bottom_navbar_widget.dart';
import 'farmers_dashboard.dart';
import 'farmers_products.dart';
import 'farmers_profile.dart';

class FarmersBottomNavbar extends StatelessWidget{
  const FarmersBottomNavbar({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        BottomNavbarWidget(
          menuScreens: [
            FarmersDashboard(),
            FarmersProducts(),
            FarmersProfile(),
          ],
          menuItems: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}