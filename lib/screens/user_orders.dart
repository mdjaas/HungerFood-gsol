import 'package:flutter/material.dart';

import 'package:g_solution/widgets/user_ordered_product.dart';

class UserOrders extends StatelessWidget{
  const UserOrders({super.key});

  @override
  Widget build(BuildContext context){
    return const SafeArea(
      child: Scaffold(
          body:
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: UserOrderedProduct(),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: UserOrderedProduct(),
              ),
            ],
          )
      ),

    );
  }
}