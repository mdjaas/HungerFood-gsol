import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:g_solution/widgets/user_ordered_product.dart';
import 'package:g_solution/providers/user_provider.dart';

class UserOrders extends StatelessWidget {

  UserOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String? userId = userProvider.user?.uid;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('cart')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No orders found."));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var orderData = snapshot.data!.docs[index].data();
                  Timestamp timestamp = orderData['date'];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: UserOrderedProduct(
                      title: orderData['title'],
                      image: orderData['image'],
                      price: orderData["price"],
                      orderDate: timestamp.toDate(),
                      orderNo:snapshot.data!.docs[index].id ,
                      qty: orderData["qty"],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}