import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final Color? backgroundColor;
  final Color? iconThemeColor;
  final double? elevation;
  final String? title;

  AppBarWidget({
    this.backgroundColor,
    this.iconThemeColor,
    this.elevation,
    this.title,
  });


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? "", style: TextStyle(color: Colors.black),),
      iconTheme: IconThemeData(
        color: null == iconThemeColor ? Colors.blue : iconThemeColor,
      ),
      backgroundColor: null == backgroundColor ? Colors.transparent : backgroundColor,
      elevation: null == elevation ? 0 : elevation,
    );
  }
}
