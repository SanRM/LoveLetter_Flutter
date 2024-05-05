// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

//1. -----------------------
//1. Mensaje que se desplaza


String message =

'(ɔ ˘ ³˘)ɔ🤍 ¡En este día tan especial quiero expresarte todo el amor y la ternura que siento por ti!. ' +
'Eres la luz que ilumina mi vida, la razón de mi sonrisa y el latido de mi corazón, ' +
'cada momento a tu lado es un regalo del cielo y cada palabra que compartimos es una melodía de amor 🤍(ˆ⌣ˆԅ)ɔ. ' +
'Te amo más allá de las palabras y deseo que este mensaje te llene de alegría y felicidad. ¡Eres mi todo!';


//2. -----------------------
//2. Colores de enfasis 
Color enfasisColor = const Color.fromARGB(255, 0, 81, 255);
Color borderColor = const Color.fromARGB(255, 29, 29, 29);

Color enfasisColorLight = enfasisColor.lighten(30);
Color enfasisColorDark = enfasisColor.darken(15);


//10. -----------------------------------------
//10. Imagenes que se despliegan en la pantalla

String bannerImage = 'decoration_images/bannerImage.jpeg';

String pageBackground = 'background_images/pageBackground.jpg';
String modelBackground = 'background_images/modelBackground.jpg';


//6. -----------------------------------------
//6. Card #1
bool cardIsActive1 = true;
String cardFrontImage1 = 'card1/front.jpeg';
String cardBackImage1 = 'card1/back.jpg';
String cardImagetext1 = 'test';

//6. -----------------------------------------
//6. Card #2
bool cardIsActive2 = true;
String cardFrontImage2 = 'card2/front.jpeg';
String cardBackImage2 = 'card2/back.jpg';
String cardImagetext2 = 'test';

//6. -----------------------------------------
//6. Card #3
bool cardIsActive3 = true;
String cardFrontImage3 = 'card3/front.jpeg';
String cardBackImage3 = 'card3/back.jpg';
String cardImagetext3 = 'test';

//6. -----------------------------------------
//6. Card #4
bool cardIsActive4 = true;
String cardFrontImage4 = 'card4/front.jpeg';
String cardBackImage4 = 'card4/back.jpg';
String cardImagetext4 = 'test';

//5. ----------------------
//5. Reproductor de youtube

String youtubeApiKey = 'AIzaSyBRqdS9lFF3o_nR55Yp1R38Od8qXmENVYo';

String videoInicialId = 'jfKfPfyJRdk';

String playlist1Id = 'PLeTy2N15mY-sH9g20yn4hqtba7siPDrQv&si=EGUnc06sLBHBVQT8';
String playlist2Id = 'PLMaXlNzA5SDBuniEPDMz3Hlqsdb8UocIk&si=eyjKJJ8q5d4gzKYt';
String playlist3Id = 'PLMaXlNzA5SDD4wGRvVtcy3O2JKLiQkWkg&si=JSQRL47lmlFYtMgy';


//7. ------------------
//7. Modelo 3d

String model3d = 'assets/3dModel/scene.glb';


//8. ----------------
//8. Tipografia
String fontFamily1 = 'goudy_bookletter_1911';


//9. ------------------
//9. Frases

Map<String, Map<String, List<String>>> frases = {
  
  'Motivation': {
    'sujetos': [
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
    'verbos': [
      'te llevará a',
      'conducirá a',
      'te guiará a',
      'te dirigirá a',
      'te impulsará a',
    ],
    'complementos': [
      'un futuro brillante',
      'alcanzar todas tus metas',
      'complir tus sueños',
      'logros impresionantes',
      'cumplir todos tus objetivos',
      'realizar todas tus metas',
      'cumplir tus sueños',
      'conquistar tus metas',
      'un futuro brillante',
      'alcanzar tus aspiraciones',
      'un futuro prometedor',
    ],
  },

  'Kind': {
    'sujetos': [
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
    'verbos': [
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
    'complementos': [
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
  },

  'Love': {
    'sujetos': [
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
    'verbos': [
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
    'complementos': [
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
  }
  
};
