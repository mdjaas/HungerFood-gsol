import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:g_solution/widgets/business_product_widget.dart';
import 'package:g_solution/providers/user_provider.dart';

class FarmersProducts extends StatelessWidget{
  const FarmersProducts({super.key});

  @override
  Widget build(BuildContext context){
    final userProvider = Provider.of<UserProvider>(context);
    String user = userProvider.user?.uid ?? '';

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user)
              .collection('userProducts')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child:CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> userProducts = [];
              for (QueryDocumentSnapshot document in snapshot.data!.docs) {
                Map<String, dynamic> productData = {
                  'productName': document['productName'],
                  'description': document['description'],
                  'price': document['price'],
                  'category': document['category'],
                  'imageURL': document['imageURL'],
                };
                userProducts.add(productData);
              }

              return ListView.builder(
                itemCount: userProducts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: BusinessProductWidget(
                      heading: userProducts[index]['productName'],
                      postingDay: 'Today',
                      price: userProducts[index]['price'].toString(),
                      desc: userProducts[index]['description'],
                      image: userProducts[index]['imageURL'],
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, 'farmersAddProduct');
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}