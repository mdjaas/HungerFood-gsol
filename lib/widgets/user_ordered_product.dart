import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserOrderedProduct extends StatelessWidget {
  final String? image;
  final DateTime? orderDate;
  final String? price;
  final String? title;
  final int? qty;
  final String? orderNo;

  const UserOrderedProduct({
    Key? key,
    this.image,
    this.qty,
    this.price,
    this.title,
    this.orderDate,
    this.orderNo,
  });

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
          Padding(padding: EdgeInsets.symmetric(horizontal: 10,),
            child: Image.network(image!, width: 100, height: 100,),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$orderDate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      ),
                      Text("Rs. " + price!),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("$qty" + "pcs"),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusted this line
                    children: [
                      Text(orderNo ?? ""),
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
