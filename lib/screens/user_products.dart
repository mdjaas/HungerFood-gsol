import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/store_filter.dart';
import 'package:g_solution/widgets/user_products_widget.dart';
import 'package:g_solution/screens/user_items_lists.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collectionGroup('userProducts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> allUsersProducts = [];
              for (QueryDocumentSnapshot document in snapshot.data!.docs) {
                Map<String, dynamic> productData = {
                  'image': document['imageURL'],
                  'title': document['productName'],
                  'price': document['price'],
                  'location': document['description'],
                };
                allUsersProducts.add(productData);
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const TextFieldWidget(
                        hintPlaceholder: 'Search for beverages, meals, etc',
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
                      child: Row(
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserItemsList(title:"Grocery" ,),
                              ),
                            );
                          },
                            child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: StoreFilter(storeType: "Grocery", image: "assets/food.png"),
                          ),
                          ),

                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserItemsList(title:"Bakery" ,category: "Bakery"),
                              ),
                            );
                          },
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: StoreFilter(storeType: "Bakery", image: "assets/food.png"),
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>const UserItemsList(title:"Restaurant" ,category: "Meals"),
                              ),
                            );
                          },
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: StoreFilter(storeType: "Restaurant", image: "assets/food.png"),
                            ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserItemsList(title:"Farm" ,category: "Farm"),
                              ),
                            );
                          },
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: StoreFilter(storeType: "Farm", image: "assets/food.png"),
                            ),
                          ),
                        ],
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
                                          const UserItemsList(title:"Foods at your locality" ,),
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
                        itemCount: allUsersProducts.length,
                        itemBuilder: (context, index) {
                          return Container(

                            child: UserProductsWidget(
                              image: allUsersProducts[index]['image'],
                              title: allUsersProducts[index]['title'],
                              price: allUsersProducts[index]['price'],
                              location: "Al Rahim Cafe, Anna Nager",
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
                                       builder: (context) => const UserItemsList(title: "Free deals at your locality" ),
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
                        itemCount: allUsersProducts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: UserProductsWidget(
                              image: allUsersProducts[index]['image'],
                              title: allUsersProducts[index]['title'],
                              price: 'Free', // Assuming 'price' represents the deal type
                              location: "Al Rahim Cafe, Anna Nager",
                            ),
                          );
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
