import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:g_solution/widgets/user_items_widget.dart';
import 'package:g_solution/widgets/app_bar_widget.dart';

class UserItemsList extends StatelessWidget {
  final String? title;
  final String? category;

  const UserItemsList({
    Key? key,
    this.title,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup('userProducts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Map<String, dynamic>> allUsersProducts = [];
              for (QueryDocumentSnapshot document in snapshot.data!.docs) {
                if (document['category']==category) {
                  Map<String, dynamic> productData = {
                    'image': document['imageURL'],
                    'title': document['productName'],
                    'price': document['price'],
                    'location': document['description'],
                  };
                  allUsersProducts.add(productData);
                }
              }

              return Column(
                children: [
                  AppBarWidget(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconThemeColor: Colors.black,
                    title: title,
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: allUsersProducts.length,
                      itemBuilder: (context, index) {
                        final product = allUsersProducts[index];
                        return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: UserItemsWidget(
                              image: product['image'],
                              title: product['title'],
                              price: product['price'],
                              location: product['location'],
                            )
                        );
                      },
                    ),

                ],
              );
            }
          },
        ),
      ),
    );
  }
}