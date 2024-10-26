import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../style_const.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    super.key,
    required BuildContext context,
    required String title,
    Color super.backgroundColor = StyleConst.kcolorCafe,
    Color titleColor = Colors.white,
    FontWeight titleWeight = FontWeight.bold,
    double toolbarHeight = 60,
    bool automaticallyImplyLeading = false,
    Widget? leading,
  }) : super(
          titleTextStyle: const TextStyle(
            color: StyleConst.kcolorBlanco,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          toolbarHeight: 60,
          title: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(title),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 72,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 24),
              IconButton.filled(
                style: const ButtonStyle().copyWith(
                  backgroundColor: const WidgetStatePropertyAll(StyleConst.kcolorBlanco),
                ),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(
                  maxWidth: 44,
                  maxHeight: 44,
                ),
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: StyleConst.kcolorCafe,
                ),
              ),
            ],
          ),
        );
}
