import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:g_solution/widgets/cart_widget.dart';
import 'package:g_solution/providers/cart_provider.dart';
import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/providers/user_provider.dart';
import '../models/cart_model.dart';
import '../models/user_model.dart';


class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          title: "My Cart",
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: cartProvider.cartItems.isEmpty
                    ? Center(
                  child: Text('Your cart is empty.'),
                )
                    : ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return CartWidget(
                      image: cartItem.image,
                      title: cartItem.title,
                      qty: cartItem.qty,
                      price: cartItem.price,
                      productId:cartItem.documentId ,
                    );
                  },
                ),
              ),
              InkWellWidget(
                buttonName: "Reserve Now",
                fontSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                onPress: ()async{
                  final currentUser = userProvider.user;

                  try {
                    await _storeCartInFirestore(currentUser!, cartProvider.cartItems);
                    cartProvider.cartItems=[];
                    cartProvider.notifyListeners();
                  } catch (error) {
                    print("Error storing cart in Firestore: $error");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _storeCartInFirestore(User currentUser, List<CartModel> cartItems) async {
    try {
      final CollectionReference cartCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('cart');

      for (var cartItem in cartItems) {
        await cartCollection.add({
          'image': cartItem.image,
          'title': cartItem.title,
          'qty': cartItem.qty,
          'price': cartItem.price,
          'date':  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        });
      }
    } catch (error) {
      print("Error storing cart in Firestore: $error");
    }
  }
}
