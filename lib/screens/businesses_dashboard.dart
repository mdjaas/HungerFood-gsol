import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({Key? key});

  @override
  _BusinessDashboardState createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  int bakery = 0;
  int meals = 0;
  int grocery = 0;

  int bakeryEarnings = 0;
  int mealsEarnings = 0;
  int groceryEarnings = 0;

  Future<void> getSaleCount() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String user = userProvider.user?.uid ?? '';
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('userProducts')
        .get();

    querySnapshot.docs.forEach((doc) {
      if (doc['quantity'] == 0) {
        String category = doc['category'];
        String price = doc['price'];

        switch (category) {
          case 'Bakery':
            setState(() {
              bakery++;
              bakeryEarnings += int.parse(price);
            });
            break;
          case 'Meals':
            setState(() {
              meals++;
              mealsEarnings += int.parse(price);
            });
            break;
          case 'Grocery':
            setState(() {
              grocery++;
              groceryEarnings += int.parse(price);
            });
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSaleCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80, left: 10),
            child: Text(
              "TOTAL FOOD SAVED",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80,),
            child: Text(
              "Bakery: $bakery",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text(
              "Meals: $meals",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text(
              "Grocery: $grocery",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80, left: 10),
            child: Center(
              child: Text(
                "TOTAL MONEY EARNED",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 80,),
            child: Text(
              "Bakery: $bakeryEarnings",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text(
              "Meals: $mealsEarnings",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text(
              "Grocery: $groceryEarnings",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
