import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/providers/cart_provider.dart';

class UserItemsWidget extends StatefulWidget {
  final String? image;
  final String? title;
  final String? price;
  final String? location;
  final String? closes;
  final String? productId;

  const UserItemsWidget({
    Key? key,
    this.title,
    this.image,
    this.location,
    this.closes,
    this.price,
    this.productId,
  }) : super(key: key);

  @override
  _UserItemsWidgetState createState() => _UserItemsWidgetState();
}

class _UserItemsWidgetState extends State<UserItemsWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int counter = cartProvider.getQuantity(widget.productId!);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          Image.network(
            widget.image!,
            height: 100,
            width: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        widget.title ?? "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        widget.price ?? "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.location ?? "",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Closes ${widget.closes ?? "12:00AM"}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    height: 20,
                    child: Row(
                      children: [
                        InkWellWidget(
                          buttonName: "-",
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          onPress: () async {
                            if (counter > 0) {
                              await cartProvider.reduceQuantity(widget.productId!);
                              setState(() {
                                counter = cartProvider.getQuantity(widget.productId!);
                              });
                              if (counter == 0) {
                                await cartProvider.removeFromCart(widget.productId!);
                              }
                            }
                          },
                        ),
                        Container(
                          width: 60,
                          child: Center(
                            child: Text("$counter"),
                          ),
                        ),
                        InkWellWidget(
                          buttonName: "+",
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          onPress: () async {
                            await cartProvider.addToCart(widget.productId!, widget.title!, 1, widget.price!, widget.image!);
                            setState(() {
                              counter = cartProvider.getQuantity(widget.productId!);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
