import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/providers/cart_provider.dart';


class CartWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? price;
  final int? qty;
  final String? productId;

  const CartWidget({
    Key? key,
    this.image,
    this.title,
    this.price,
    this.qty,
    this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Image.network(image ?? "", height: 100, width: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? ""),
              SizedBox(height: 10),
              Text("Rs. ${price.toString() ?? ''}"),
              SizedBox(height: 10),
              Text("$qty nos."),
            ],
          ),
          SizedBox(width: 50),
          Center(
            child: InkWellWidget(
              buttonName: "Delete",
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onPress: (){
                cartProvider.removeFromCart(productId!);
              },
            ),
          )
        ],
      ),
    );
  }
}
