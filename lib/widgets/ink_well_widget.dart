import 'package:flutter/material.dart';

class InkWellWidget extends StatelessWidget{

  final Color? buttonColor;
  final VoidCallback? onPress;
  final String? buttonName;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  InkWellWidget({
    this.buttonColor,
    this.onPress,
    this.padding,
    this.buttonName,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context){
    return Material(
        child:Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: buttonColor ?? Colors.redAccent,
            ),

            child: InkWell(
              onTap: onPress,
              child: Padding(
                padding: padding ?? EdgeInsets.all(0),
                child: Center(
                    child: Text(
                      buttonName ?? '',
                      style: TextStyle(fontSize: fontSize),
                    ),
                ),),
            )
        )
    );
  }
}