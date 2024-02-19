// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

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
                      fontFamily: 'goudy',
                      fontWeight: FontWeight.bold,
                      fontSize: responsiveHeight / 40,
                      color: Color.fromARGB(255, 54, 101, 255),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 201, 214, 255),
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
                    fontFamily: 'goudy',
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

    String frase =
        '${sujetos[random.nextInt(sujetos.length)]} ${verbos[random.nextInt(verbos.length)]} ${complementos[random.nextInt(complementos.length)]}';

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
  List<Map<String, String>> phrasesByThopic = [];

  GeneratePhrase lovePhrases = LovePhrase();
  GeneratePhrase motivationPhrases = MotivationPhrase();
  GeneratePhrase kindPhrases = KindPhrase();

  addPhrasesToThopicList() {
    String lovePhrase = generateLovePhrase();
    String motivationPhrase = generateMotivationPhrase();
    String kindPhrase = generateKindPhrase();

    phrasesByThopic.add({'phrase': lovePhrase, 'type': 'love'});
    phrasesByThopic.add({'phrase': motivationPhrase, 'type': 'motivation'});
    phrasesByThopic.add({'phrase': kindPhrase, 'type': 'kind'});

    //print('Las frases son: $phrasesByThopic');
  }

  String generateLovePhrase() => lovePhrases.generatePhrase();
  String generateMotivationPhrase() => motivationPhrases.generatePhrase();
  String generateKindPhrase() => kindPhrases.generatePhrase();

  generateFinalPhrase() {
    addPhrasesToThopicList();

    Random random = Random();
    return phrasesByThopic[random.nextInt(phrasesByThopic.length)];
  }
}

class MotivationPhrase extends GeneratePhrase {
  MotivationPhrase()
      : super(
          sujetos: [
            'Tu determinación',
            'Tu esfuerzo',
            'Tu perseverancia',
            'Tu pasión',
            'Tu coraje',
            'Tu dedicación',
            'Tu entusiasmo',
            'Tu constancia',
            'Tu entrega',
            'Tu voluntad',
            'Tu fuerza de voluntad',
            'Tu perseverancia',
          ],
          verbos: [
            'te llevará a',
            'conducirá a',
            'te guiará a',
            'te llevará a',
            'te dirigirá a',
            'te impulsará a',
            'te encaminará a',
          ],
          complementos: [
            'grandes logros',
            'un futuro brillante',
            'tus metas alcanzadas',
            'tus sueños',
            'logros impresionantes',
            'tus objetivos',
            'tus metas',
            'tus sueños',
            'conquistar tus metas',
            'un futuro brillante',
            'alcanzar tus aspiraciones',
            'un futuro prometedor',
          ],
        );
}

class KindPhrase extends GeneratePhrase {
  KindPhrase()
      : super(
          sujetos: [
            'Mi cariño',
            'Mi sueño',
            'Mi inspiración',
            'Mi luz',
            'Mi anhelo',
            'Mi felicidad',
            'Mi alegría',
            'Mi motivación',
            'Mi fuerza',
          ],
          verbos: [
            'existe por',
            'origina de',
            'nace de',
            'emana',
            'surge de',
            'proviene de',
            'florece por',
            'se nutre de',
            'se llena de',
          ],
          complementos: [
            'ti',
            'ti, mi tesoro',
            'ti, mi todo',
            'ti, mi amor',
            'ti, cosita bonita',
            'ti, mi niña',
            'ti, mi vida',
            'tu amor',
            'tu sonrisa',
            'tu ser',
            'tu esencia',
            'tu calidez',
            'tu compañía',
            'tu ternura',
            'tu dulzura',
          ],
        );
}

class LovePhrase extends GeneratePhrase {
  LovePhrase()
      : super(
          sujetos: [
            'Tu sonrisa',
            'Tu felicidad',
            'Tu ternura',
            'Tu cariño',
            'Tu amor',
            'Tu compañía',
            'Tu calidez',
            'Tu mirada',
            'Tu presencia',
            'Tu esencia',
            'Tu apoyo',
            'Tu luz',
            'Tu ser',
          ],
          verbos: [
            'ilumina',
            'dulcifica',
            'endulza',
            'embellece',
            'mejora',
            'alegra',
            'enriquece',
            'alumbra',
            'anima',
            'contenta',
            'potencia',
            'fortalece',
          ],
          complementos: [
            'mi día',
            'mi vida',
            'mi mundo',
            'mi corazón',
            'mi existencia',
            'mi universo',
            'mi ser',
            'mi realidad',
            'mis dias',
          ],
        );
}
