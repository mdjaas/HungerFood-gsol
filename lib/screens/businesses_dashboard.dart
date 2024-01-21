import 'package:flutter/material.dart';

class BusinessDashboard extends StatelessWidget{
  const BusinessDashboard ({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body:
      Column(
        children: [

          Padding(
              padding: EdgeInsets.only(top: 80, left: 10),
              child: Text("TOTAL FOOD SAVED",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontStyle: FontStyle.italic),
              )
          ),

          Padding(
            padding: EdgeInsets.only(top: 80,),
            child: Text("Cooked Foods 45%",
            style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text("Fruits & veg 25%",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text("Others 30%",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 80, left: 0),
              child: Text("TOTAL EARNED",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontStyle: FontStyle.italic),
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 80,),
            child: Text("Cooked Foods Rs. 200",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text("Fruits & veg Rs. 80",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Text("Others Rs. 120",
              style: TextStyle(fontSize: 20),
            ),
          ),

        ],
      ),
    );
  }
}