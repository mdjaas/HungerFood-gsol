import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final Color? backgroundColor;
  final Color? iconThemeColor;
  final double? elevation;

  AppBarWidget({
    this.backgroundColor,
    this.iconThemeColor,
    this.elevation,
  });


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: null == iconThemeColor ? Colors.blue : iconThemeColor,
      ),
      backgroundColor: null == backgroundColor ? Colors.transparent : backgroundColor,
      elevation: null == elevation ? 0 : elevation,
    );
  }
}
