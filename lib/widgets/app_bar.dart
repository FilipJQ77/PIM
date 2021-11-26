import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

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
            // todo chyba start popup cos zepsul bo po kliknieciu w logo jest czarny ekran
            Navigator.of(context).pop();
          },
          iconSize: preferredSize.height * 2,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
