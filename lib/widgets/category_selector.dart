import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget{
  final String? image;
  final String? category;
  final String? value;
  final String? groupValue;
  final Function(String)? onClick;

  const CategorySelector({
    super.key,
    this.image,
    this.category,
    this.value,
    this.groupValue,
    this.onClick,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: (){
          onClick!(value!);
        },
        child: Expanded(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: groupValue == value ? Colors.green.shade900 : Colors.grey,
                width: 2.0,
              ),
            ),
            child: Column(
              children: [
                Image.asset(image!, width: 80, ),
                Text(category ?? ""),
              ],
            ),
          ),
        ),
    );
  }
}