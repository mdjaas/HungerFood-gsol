import 'package:flutter/material.dart';

import 'package:g_solution/widgets/business_product_widget.dart';
import 'package:g_solution/widgets/bottom_navbar_widget.dart';

class BusinessProducts extends StatelessWidget{
  const BusinessProducts({super.key,});

  @override
  Widget build(BuildContext context){

    return const SafeArea(
      child: Scaffold(
          body:
              Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: BusinessProductWidget(
                      heading: 'Chicken Burger',
                      postingDay: 'Today',
                      price: '25',
                      desc: 'Cooked today evening. Tastes very good',
                    ),
                  ),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: BusinessProductWidget(
                      heading: 'Veg Burger',
                      postingDay: 'Today',
                      price: 'Free',
                      desc: 'Cooked today evening. Tastes very good',
                    ),
                  ),

                ],
              ),
      ),
    );
  }
}