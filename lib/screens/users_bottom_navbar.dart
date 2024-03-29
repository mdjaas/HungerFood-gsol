import 'package:flutter/material.dart';

import 'package:g_solution/widgets/bottom_navbar_widget.dart';
import 'user_products.dart';
import 'user_orders.dart';
import 'user_profile.dart';
import 'cart.dart';

class UserBottomNavbar extends StatelessWidget{
  const UserBottomNavbar({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        BottomNavbarWidget(
          menuScreens: [
            UserProducts(),
            UserOrders(),
            Cart(),
            UserProfile(),
          ],
          menuItems: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
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