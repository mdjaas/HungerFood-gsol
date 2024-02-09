import 'package:flutter/material.dart';

class StoreFilter extends StatelessWidget{
  final String? image;
  final String? storeType;

  StoreFilter({
    super.key,
    this.image,
    this.storeType,
  });

  @override
  Widget build(BuildContext context){

    return Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
             child: Image.asset(image!),
            ),
            Text(storeType!),
          ],
        );
  }
}