import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/screens/home.dart';

class BabbleAppBar extends StatelessWidget with PreferredSizeWidget {
  const BabbleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: IconButton(
          icon: Image.asset('assets/images/BabbleHome.png',
              color: AppColors.white),
          onPressed: () {
            Navigator.of(context).pop();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          iconSize: preferredSize.height * 2,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
