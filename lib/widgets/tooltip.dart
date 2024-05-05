
import 'package:flutter/material.dart';

import '../config/config.dart';

class AppToolTip extends StatefulWidget {
  const AppToolTip({required this.child, required this.text, super.key});

  final Widget child;
  final String text;

  @override
  State<AppToolTip> createState() => _AppToolTipState();
}

class _AppToolTipState extends State<AppToolTip> {

  @override
  Widget build(BuildContext context) {

    double responsiveHeight = MediaQuery.of(context).size.height;

    return InkWell(
      child: Tooltip(
        enableTapToDismiss: true,
        message: '📄 ${widget.text}',
        textStyle: TextStyle(
          fontFamily: fontFamily1,
          fontSize: responsiveHeight / 42,
          fontWeight: FontWeight.bold,
          color: enfasisColorDark.withOpacity(0.7),
        ),
        decoration: BoxDecoration(
          color: enfasisColorLight.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        verticalOffset: responsiveHeight / 28,
        exitDuration: const Duration(seconds: 1),
        child: widget.child,
      ),
    );
    
  }
}
