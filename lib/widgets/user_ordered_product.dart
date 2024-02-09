import 'package:flutter/material.dart';

class UserOrderedProduct extends StatelessWidget {
  const UserOrderedProduct({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/food.png", width: 100, height: 100,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ordered Today",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Burger",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text("Rs. 10"),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusted this line
                    children: [
                      Text("Order no. 122233"),
                      Text("10 pcs"),
                    ],
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}
