import 'package:flutter/material.dart';
import 'package:project_a/widgets/phrase_manager/phrase_manager.dart';
import 'package:tinycolor2/tinycolor2.dart';

import '../../config/config.dart';

class PhraseTypeButton extends StatefulWidget {
  final String buttonphraseType;
  final ValueNotifier<String> phraseNotifier;
  final Color buttonColor;
  final double responsiveWidth;
  final double responsiveHeight;
  final Function onTap;

  const PhraseTypeButton({
    super.key,
    required this.onTap,
    required this.buttonColor,
    required this.buttonphraseType,
    required this.responsiveWidth,
    required this.responsiveHeight,
    required this.phraseNotifier,
  });

  @override
  State<PhraseTypeButton> createState() => _PhraseTypeButtonState();
}

class _PhraseTypeButtonState extends State<PhraseTypeButton> {
  late Color backgroundColor;
  late double iconSize;

  @override
  void initState() {
    backgroundColor = widget.buttonColor;
    iconSize = widget.responsiveHeight / 75;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return phraseTypeButton(context);
  }

  InkWell phraseTypeButton(BuildContext context) {
    return InkWell(
      onTap: () {
        changePhraseByType();
        widget.onTap();
        showSnackBar(context);
        //print('El valor de la frase actual es: ${widget.phraseNotifier.value}');
      },
      onHover: (value) {
        changeButtonColorOnHover(value);
        changeiconSizeOnHover(value);
      },
      child: AnimatedContainer(
        width: widget.responsiveWidth / 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: backgroundColor,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        child: Icon(
          Icons.star_rate_rounded,
          color: widget.buttonColor.darken(20),
          size: iconSize,
        ),
      ),
    );
  }

  void changeButtonColorOnHover(bool value) {
    if (value) {
      setState(
        () {
          backgroundColor = widget.buttonColor.darken(8);
        },
      );
    } else {
      setState(() {
        backgroundColor = widget.buttonColor;
      });
    }
  }

  String renamePhraseType() {
    switch (widget.buttonphraseType) {
      case 'love':
        return 'romantica';
      case 'motivation':
        return 'motivacional';
      default:
        return 'cariñosa';
    }
  }

  void changePhraseByType() {
    switch (widget.buttonphraseType) {
      case 'love':
        widget.phraseNotifier.value =
            GenerateRandomPhraseWithThopic().generateLovePhrase();
        break;
      case 'motivation':
        widget.phraseNotifier.value =
            GenerateRandomPhraseWithThopic().generateMotivationPhrase();
        break;
      case 'kind':
        widget.phraseNotifier.value =
            GenerateRandomPhraseWithThopic().generateKindPhrase();

        break;
    }
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        '¡Nueva frase ${renamePhraseType()} ⭐!',
        style: TextStyle(
          fontFamily: fontFamily1,
          fontWeight: FontWeight.bold,
          fontSize: widget.responsiveHeight / 80,
          color: backgroundColor.darken(50),
        ),
      ),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void changeiconSizeOnHover(bool value) {
    if (value) {
      setState(() {
        iconSize = widget.responsiveHeight / 60;
      });
    } else {
      setState(() {
        iconSize = widget.responsiveHeight / 75;
      });
    }
  }
}
