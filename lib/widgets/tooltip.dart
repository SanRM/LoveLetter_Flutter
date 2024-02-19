import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

class AppToolTip extends StatefulWidget {

  const AppToolTip({required this.child, required this.text, super.key});

  final Widget child;
  final String text;

  @override
  State<AppToolTip> createState() => _AppToolTipState();
}

class _AppToolTipState extends State<AppToolTip> {

  late Color principalColor;

  @override
  Widget build(BuildContext context) {

    double responsiveHeight = MediaQuery.of(context).size.height;
    Random random = Random();
    
    principalColor = Color.fromRGBO(random.nextInt(100) + 150, random.nextInt(100) + 150, random.nextInt(100) + 150, 148);

    return Tooltip(
          message: '📄 ${widget.text}',
          textStyle: TextStyle(
            fontFamily: 'goudy',
            fontSize: responsiveHeight / 40,
            fontWeight: FontWeight.bold,
            color: principalColor.darken(100),
          ),
          decoration: BoxDecoration(
            color: principalColor.darken(5),
            borderRadius: BorderRadius.circular(10),
          ),
          verticalOffset: responsiveHeight / 28,
          exitDuration: const Duration(seconds: 1),
          child: widget.child,
        );
    
  }
}