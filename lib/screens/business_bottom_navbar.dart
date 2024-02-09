import 'package:flutter/material.dart';

import 'package:g_solution/widgets/bottom_navbar_widget.dart';
import 'business_products.dart';
import 'businesses_dashboard.dart';
import 'business_profile.dart';

class BusinessBottomNavbar extends StatelessWidget{
  const BusinessBottomNavbar({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
        resizeToAvoidBottomInset: false,
      body:
        BottomNavbarWidget(menuScreens: [
          BusinessDashboard(),
          BusinessProducts(),
          BusinessProfile(),
        ],
        menuItems: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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