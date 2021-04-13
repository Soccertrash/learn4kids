import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn4kids/view/styles/buttonSizes.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: ButtonSizes.iconSize,
      onPressed: () => Navigator.pop(context),
    );
  }
}
