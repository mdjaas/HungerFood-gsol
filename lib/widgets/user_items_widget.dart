import "package:flutter/material.dart";

import 'package:g_solution/widgets/ink_well_widget.dart';

class UserItemsWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? price;
  final String? location;
  final String? closes;
  const UserItemsWidget({
    Key? key,
    this.title,
    this.image,
    this.location,
    this.closes,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          Image.network(
            image!,
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
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                        child: Text(
                          title ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                      child: Text(
                        price ?? "",
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
                    child: Text(location ?? "",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Closes 12:00AM",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child:Container(

                      height: 20,
                      child: Row(
                        children: [
                          InkWellWidget(
                            buttonName: "-",
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          ),
                          Container(
                            width: 60,
                            child: Center(
                              child:Text("1"),
                            ),
                          ),
                          InkWellWidget(
                            buttonName: "+",
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          ),
                        ],
                      )
                  ),
                )
                              ],
            ),
          ),
        ],
      ),
    );
  }
}
