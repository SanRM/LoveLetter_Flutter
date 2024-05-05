// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';

class PhraseManager extends StatelessWidget {
  final double responsiveHeight;
  final ValueNotifier<String> phraseNotifier;
  const PhraseManager(
      {required this.responsiveHeight,
      super.key,
      required this.phraseNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: phraseNotifier,
      builder: (context, value, child) {
        String phrase = phraseNotifier.value;

        return InkWell(
          onTap: () {
            FlutterClipboard.copy(phrase).then(
              (value) {
                //print('copied');
                final snackBar = SnackBar(
                  content: Text(
                    'Frase copiada en el portapapeles 🤍',
                    style: TextStyle(
                      fontFamily: fontFamily1,
                      fontWeight: FontWeight.bold,
                      fontSize: responsiveHeight / 40,
                      color: enfasisColorDark.withOpacity(0.8),
                    ),
                  ),
                  backgroundColor: enfasisColorLight,
                );
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
            );
          },
          child: FittedBox(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: responsiveHeight / 40,
              ),
              child: Text(
                phrase,
                style: TextStyle(
                  fontFamily: fontFamily1,
                  fontSize: responsiveHeight / 13,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 48, 48, 48),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

abstract class GeneratePhrase {
  List<String> sujetos = [];
  List<String> verbos = [];
  List<String> complementos = [];

  GeneratePhrase({
    this.sujetos = const [''],
    this.verbos = const [''],
    this.complementos = const [''],
  });

  String generatePhrase() {
    var random = Random();

    String frase = '${sujetos[random.nextInt(sujetos.length)]} ${verbos[random.nextInt(verbos.length)]} ${complementos[random.nextInt(complementos.length)]}';

    return removeDoubleSpaces(frase);
  }

  String removeDoubleSpaces(String str) {
    while (str.contains('  ')) {
      str = str.replaceAll('  ', ' ');
    }
    return str;
  }
}

class GenerateRandomPhraseWithThopic {
  List<Map<String, String>> phrasesThopicList = [];

  GeneratePhrase lovePhrases = LovePhrase();
  GeneratePhrase motivationPhrases = MotivationPhrase();
  GeneratePhrase kindPhrases = KindPhrase();

  generateFinalPhrase() {
    addPhrasesToThopicList();

    Random random = Random();
    return phrasesThopicList[random.nextInt(phrasesThopicList.length)];
  }
  
  addPhrasesToThopicList() {
    String lovePhrase = generateLovePhrase();
    String motivationPhrase = generateMotivationPhrase();
    String kindPhrase = generateKindPhrase();

    phrasesThopicList.add({'phrase': lovePhrase, 'type': 'love'});
    phrasesThopicList.add({'phrase': motivationPhrase, 'type': 'motivation'});
    phrasesThopicList.add({'phrase': kindPhrase, 'type': 'kind'});

    //print('Las frases son: $phrasesByThopic');
  }

  String generateLovePhrase() => lovePhrases.generatePhrase();
  String generateMotivationPhrase() => motivationPhrases.generatePhrase();
  String generateKindPhrase() => kindPhrases.generatePhrase();

}

class MotivationPhrase extends GeneratePhrase {
  MotivationPhrase()
      : super(
          sujetos: frases['Motivation']!['sujetos']!,
          verbos: frases['Motivation']!['verbos']!,
          complementos: frases['Motivation']!['complementos']!,
        );
}

class KindPhrase extends GeneratePhrase {
  KindPhrase()
      : super(
          sujetos: frases['Kind']!['sujetos']!,
          verbos: frases['Kind']!['verbos']!,
          complementos: frases['Kind']!['complementos']!,
        );
}

class LovePhrase extends GeneratePhrase {
  LovePhrase()
      : super(
          sujetos: frases['Love']!['sujetos']!,
          verbos: frases['Love']!['verbos']!,
          complementos: frases['Love']!['complementos']!,
        );
}
