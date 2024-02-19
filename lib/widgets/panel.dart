import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final String? photo;
  final int flex;
  final Widget? child;
  final EdgeInsets margin;

  const PanelWidget({super.key, this.photo, this.flex = 1, this.child, this.margin = const EdgeInsets.only(top: 10, left: 10, right: 10)});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: margin,
        height: double.infinity,
        decoration: BoxDecoration(
          image: photo != null
              ? DecorationImage(
                  image: AssetImage(photo!),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(185, 255, 255, 255),
          border: Border.all(
              color: const Color.fromARGB(240, 44, 44, 44), width: 2),
        ),
        child: child,
      ),
    );
  }
}