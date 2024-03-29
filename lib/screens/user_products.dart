import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:geocoding/geocoding.dart';

import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/store_filter.dart';
import 'package:g_solution/widgets/user_products_widget.dart';
import 'package:g_solution/screens/user_items_lists.dart';
import 'package:g_solution/providers/user_provider.dart';

class UserProducts extends StatefulWidget {
  const UserProducts({Key? key}) : super(key: key);

  @override
  _UserProductState createState() => _UserProductState();
}

class _UserProductState extends State<UserProducts> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup('userProducts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> allUsersProducts = [];
              List<Map<String, dynamic>> freeUsersProducts = [];
              for (QueryDocumentSnapshot document in snapshot.data!.docs){
                double productLatitude = document['latitude'];
                double productLongitude = document['longitude'];
                final userProvider = Provider.of<UserProvider>(context);
                double distance = Geolocator.distanceBetween(
                  userProvider.user?.latitude ?? 0.0,
                  userProvider.user?.longitude ?? 0.0,
                  productLatitude,
                  productLongitude,
                );

                if (document['quantity'] != 0 && distance <= 5000) {
                  Map<String, dynamic> productData = {
                    'image': document['imageURL'],
                    'title': document['productName'],
                    'price': document['price'],
                    'location': document['location'],
                    'productId': document.id,
                  };
                  allUsersProducts.add(productData);
                  if (document['price']=="0"){
                    freeUsersProducts.add(productData);
                  }
                }
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AppBar(
                        title: Center(
                          child: Text(
                            "HungerFood",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Feeling hungry? Let's satisfy that craving",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserItemsList(title: "Grocery"),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: StoreFilter(storeType: "Grocery", image: "assets/grocery.png"),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserItemsList(title: "Bakery", category: "Bakery"),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: StoreFilter(storeType: "Bakery", image: "assets/bakery.png"),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserItemsList(title: "Restaurant", category: "Meals"),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: StoreFilter(storeType: "Restaurant", image: "assets/food.png"),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserItemsList(title: "Farm", category: "Farm"),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: StoreFilter(storeType: "Farm", image: "assets/wheat.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Foods at your locality",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "View More",
                                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const UserItemsList(title: "Foods at your locality", category: "all" ),
                                        ),
                                      );
                                    },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(3, allUsersProducts.length),
                        itemBuilder: (context, index) {
                          return Container(
                            child: UserProductsWidget(
                              image: allUsersProducts[index]['image'],
                              title: allUsersProducts[index]['title'],
                              price: allUsersProducts[index]['price'],
                              productId: allUsersProducts[index]['productId'],
                              location: allUsersProducts[index]['location'],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Text(
                            "Free deals at your locality",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "View More",
                                style: const TextStyle(fontSize: 20, color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const UserItemsList(title: "Free deals at your locality", price: "0"),
                                      ),
                                    );
                                  },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(3, freeUsersProducts.length),
                        itemBuilder: (context, index) {
                          if (freeUsersProducts[index]['price'] == "0") {
                            return Container(
                              child: UserProductsWidget(
                                image: freeUsersProducts[index]['image'],
                                title: freeUsersProducts[index]['title'],
                                price: freeUsersProducts[index]['price'],
                                productId: freeUsersProducts[index]['productId'],
                                location: freeUsersProducts[index]['location'],
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
