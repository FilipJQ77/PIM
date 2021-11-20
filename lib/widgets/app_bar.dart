import 'package:flutter/material.dart';
import '../app_colors.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/BabbleHome.png',
                color: AppColors.white),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 120,
          ),
        ],
      ));
}