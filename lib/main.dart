import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:localstorage/localstorage.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:project_a/config/config.dart';
import 'package:project_a/widgets/panel.dart';
import 'package:project_a/widgets/phrase_manager/phrase_manager.dart';
import 'package:project_a/widgets/tooltip.dart';
import 'package:project_a/widgets/video_widgets/reproduction_constrolls.dart';
import 'package:project_a/data/api/youtube_api/youtube_api.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'widgets/phrase_manager/phrase_types_buttons.dart';
import 'widgets/video_widgets/playlist_button.dart';

//import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  //await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  YoutubePlayerController _youtubePlayerController = YoutubePlayerController();
  Map phraseMap = {};
  String phraseType = '';

  final ValueNotifier<bool> _videoIsPlayingNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<List<String>> _actualPlaylist =
      ValueNotifier<List<String>>([]);
  final ValueNotifier<bool> _playlistIsShuffle = ValueNotifier<bool>(false);
  final ValueNotifier<String> _phraseNotifier = ValueNotifier<String>('');
  final LocalStorage storage = LocalStorage('my_app');
  final YoutubeApi youtubeApi = YoutubeApi();

  final GestureFlipCardController flipCard1Controller =
      GestureFlipCardController();
  final GestureFlipCardController flipCard2Controller =
      GestureFlipCardController();
  final GestureFlipCardController flipCard3Controller =
      GestureFlipCardController();
  final GestureFlipCardController flipCard4Controller =
      GestureFlipCardController();

  @override
  void initState() {
    handleInitialPhraseValue();
    youtubePlayerInitialConfig();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width;
    double responsiveHeight = MediaQuery.of(context).size.height;

    handleInitialPlaylistValue();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        sliderTheme: const SliderThemeData(
          disabledThumbColor: Color.fromARGB(255, 201, 214, 255),
          disabledActiveTrackColor: Color.fromARGB(255, 192, 231, 255),
          disabledInactiveTrackColor: Color.fromARGB(255, 241, 200, 255),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(pageBackground),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: Center(
            child: SizedBox(
              //color: Colors.cyan,
              width: responsiveWidth / 1.2,
              height: responsiveHeight / 1.4,
              child: Row(
                children: [
                  //left panel
                  SizedBox(
                    width: responsiveWidth / 5.3,
                    child: Column(
                      children: [
                        flipCard(
                          flipCard1Controller: flipCard1Controller,
                          cardIsActive: true,
                          cardFrontImage1: cardFrontImage1,
                          cardBackImage1: cardBackImage1,
                        ),
                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),
                        PanelWidget(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: AssetImage(modelBackground),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                            child: model3d != ''
                                ? ModelViewer(
                                    src: model3d,
                                    alt: "3D model",
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: responsiveWidth * 0.0001,
                  ),

                  SizedBox(
                    width: responsiveWidth / 2,
                    child: Column(
                      children: [
                        //top panel
                        SizedBox(
                          height: responsiveHeight / 5,
                          child: Row(
                            children: [
                              flipCard(
                                flex: 2,
                                flipCard1Controller: flipCard2Controller,
                                cardIsActive: true,
                                cardFrontImage1: cardFrontImage2,
                                cardBackImage1: cardBackImage2,
                              ),
                              SizedBox(
                                width: responsiveWidth * 0.0001,
                              ),
                              columnOfPhraseByCategoryButtons(
                                _phraseNotifier.value,
                                responsiveWidth,
                                phraseType,
                              ),
                              SizedBox(
                                width: responsiveWidth * 0.0001,
                              ),
                              PanelWidget(
                                flex: 7,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: AppToolTip(
                                    text: 'Click izquierdo para copiar',
                                    child: PhraseManager(
                                      phraseNotifier: _phraseNotifier,
                                      responsiveHeight: responsiveHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        SizedBox(
                          //botttom panel
                          height: responsiveHeight / 2.2,

                          child: Row(
                            children: [
                              //left panel, this is a model viewer

                              flipCard(
                                flex: 1,
                                flipCard1Controller: flipCard3Controller,
                                cardIsActive: true,
                                cardFrontImage1: cardFrontImage3,
                                cardBackImage1: cardBackImage1,
                              ),

                              SizedBox(
                                width: responsiveWidth / 3.15,
                                child: Column(
                                  children: [
                                    PanelWidget(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(7),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              bannerImage,
                                            ),
                                            fit: BoxFit.contain,
                                            repeat: ImageRepeat.repeatX,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: responsiveHeight * 0.01,
                                    ),
                                    PanelWidget(
                                      flex: 4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: YoutubePlayer(
                                          controller: _youtubePlayerController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        //bottom panel
                        PanelWidget(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: TextScroll(
                              message,
                              style: TextStyle(
                                fontSize: responsiveHeight / 75,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontFamily1,
                              ),
                              velocity: const Velocity(
                                pixelsPerSecond: Offset(25, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: responsiveWidth / 7,
                    child: Column(
                      children: [
                        //top panel
                        flipCard(
                          flex: 4,
                          flipCard1Controller: flipCard4Controller,
                          cardIsActive: true,
                          cardFrontImage1: cardFrontImage4,
                          cardBackImage1: cardBackImage4,
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: responsiveHeight / 14,
                          child: Row(
                            children: [
                              PanelWidget(
                                child: ReproductionVideoButton(
                                  controller: _youtubePlayerController,
                                  reproductionButtonType:
                                      ReproductionControllType.previous,
                                  playlistLength: _actualPlaylist.value.length,
                                ),
                              ),
                              PanelWidget(
                                child: ReproductionVideoButton(
                                  controller: _youtubePlayerController,
                                  reproductionButtonType:
                                      ReproductionControllType.stop,
                                  playlistLength: _actualPlaylist.value.length,
                                ),
                              ),
                              PanelWidget(
                                child: ReproductionVideoButton(
                                  controller: _youtubePlayerController,
                                  reproductionButtonType:
                                      ReproductionControllType.next,
                                  playlistLength: _actualPlaylist.value.length,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: responsiveHeight / 14,
                          child: Row(
                            children: [
                              PanelWidget(
                                child: ReproductionVideoButton(
                                  controller: _youtubePlayerController,
                                  reproductionButtonType:
                                      ReproductionControllType.mute,
                                  playlistLength: _actualPlaylist.value.length,
                                  videoIsPlayingNotifier:
                                      _videoIsPlayingNotifier,
                                ),
                              ),
                              PanelWidget(
                                child: ReproductionVideoButton(
                                  controller: _youtubePlayerController,
                                  reproductionButtonType:
                                      ReproductionControllType.shuffle,
                                  playlistLength: _actualPlaylist.value.length,
                                  videoIsPlayingNotifier:
                                      _videoIsPlayingNotifier,
                                  playlistIsShuffle: _playlistIsShuffle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        PanelWidget(
                          child: ReproductionVideoButton(
                            controller: _youtubePlayerController,
                            reproductionButtonType:  ReproductionControllType.volume,
                            playlistLength: _actualPlaylist.value.length,
                            videoIsPlayingNotifier: _videoIsPlayingNotifier,
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        PanelWidget(
                          child: ReproductionVideoButton(
                            controller: _youtubePlayerController,
                            reproductionButtonType:
                                ReproductionControllType.home,
                            playlistLength: _actualPlaylist.value.length,
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        //bottom panel
                        SizedBox(
                          width: double.infinity,
                          height: responsiveHeight / 14,
                          child: playlistButtons(
                            responsiveWidth,
                            responsiveHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded flipCard(
      {flex = 1,
      flipCard1Controller,
      cardIsActive,
      cardFrontImage1,
      cardBackImage1}) {
    return Expanded(
      flex: flex,
      child: cardIsActive1
          ? GestureFlipCard(
              animationDuration: const Duration(milliseconds: 300),
              axis: FlipAxis.vertical,
              controller: flipCard1Controller,
              enableController: true,
              frontWidget: PanelWidget(
                photo: cardFrontImage1,
                onTap: () {
                  flipCard1Controller.flipcard();
                },
              ),
              backWidget: PanelWidget(
                photo: cardBackImage1,
                onTap: () {
                  flipCard1Controller.flipcard();
                },
              ),
            )
          : PanelWidget(
              photo: cardFrontImage1,
            ),
    );
  }

  //1.
  void handleInitialPlaylistValue() {
    if (_actualPlaylist.value.isNotEmpty) {
      loadPlaylist();
    } else {
      loadVideo();
    }
  }

  void youtubePlayerInitialConfig() {
    _youtubePlayerController = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: true,
        color: 'red',
        loop: true,
        showVideoAnnotations: false,
        interfaceLanguage: 'es',
      ),
    );
  }

  void loadPlaylist() async {
    _youtubePlayerController.loadPlaylist(
      list: _actualPlaylist.value,
      listType: ListType.playlist,
      startSeconds: 0,
    );
    _youtubePlayerController.setLoop(loopPlaylists: true);
  }

  void loadVideo() {
    _youtubePlayerController.loadVideoById(videoId: 'jfKfPfyJRdk');
  }

  //2.
  void handleInitialPhraseValue() {
    isKeyStored('phrase').then((valueExists) {
      if (valueExists == true) {
        //print('Hay una frase guardada: $value');
        getPhraseValue();
      } else {
        //print('No hay una frase guardada: $value');
        phraseMap = GenerateRandomPhraseWithThopic().generateFinalPhrase();
        _phraseNotifier.value = phraseMap['phrase'];
        phraseType = phraseMap['type'];
        savePhraseValue();
      }
    });
  }

  void savePhraseValue() async {
    await storage.ready;
    storage.setItem('phrase', _phraseNotifier.value);
  }

  void getPhraseValue() async {
    await storage.ready;
    String storedValue = storage.getItem('phrase');
    _phraseNotifier.value = storedValue;
  }

  Future<bool> isKeyStored(String key) async {
    await storage.ready;
    var value = storage.getItem(key);
    return value != null;
  }

  //3.
  void unMuteVideoIfIsPlaying() {
    if (_videoIsPlayingNotifier.value) {
      _youtubePlayerController.unMute();
    }
  }

  //4.
  playlistButtons(responsiveWidth, responsiveHeight) {
    unMuteVideoIfIsPlaying();

    return Row(
      children: [
        PlaylistButton(
          responsiveHeight: responsiveHeight,
          youtubeApiInstance: youtubeApi,
          playlistId: playlist1Id,
          playlistType: PlaylistType.favorite,
          buttonColor: const Color.fromARGB(255, 255, 191, 207),
          actualPlaylist: _actualPlaylist,
          notifyParent: () {
            setState(() {});
          },
          playlistIsShuffle: _playlistIsShuffle,
          videoController: _youtubePlayerController,
        ),
        PlaylistButton(
          responsiveHeight: responsiveHeight,
          youtubeApiInstance: youtubeApi,
          playlistId: playlist2Id,
          playlistType: PlaylistType.history,
          buttonColor: const Color.fromARGB(255, 191, 226, 255),
          actualPlaylist: _actualPlaylist,
          notifyParent: () {
            setState(() {});
          },
          playlistIsShuffle: _playlistIsShuffle,
          videoController: _youtubePlayerController,
        ),
        PlaylistButton(
          responsiveHeight: responsiveHeight,
          youtubeApiInstance: youtubeApi,
          playlistId: playlist3Id,
          playlistType: PlaylistType.watchLater,
          buttonColor: const Color.fromARGB(255, 190, 255, 235),
          actualPlaylist: _actualPlaylist,
          notifyParent: () {
            setState(() {});
          },
          playlistIsShuffle: _playlistIsShuffle,
          videoController: _youtubePlayerController,
        ),
      ],
    );
  }

  //5.
  Column columnOfPhraseByCategoryButtons(
      String phrase, double responsiveWidth, String phraseType) {
    return Column(
      children: [
        PanelWidget(
          child: PhraseTypeButton(
            phraseNotifier: _phraseNotifier,
            buttonColor: const Color.fromARGB(255, 255, 191, 207),
            buttonphraseType: 'love',
            responsiveWidth: responsiveWidth,
            responsiveHeight: responsiveWidth,
            onTap: savePhraseValue,
          ),
        ),
        PanelWidget(
          child: PhraseTypeButton(
            phraseNotifier: _phraseNotifier,
            buttonColor: const Color.fromARGB(255, 191, 226, 255),
            buttonphraseType: 'motivation',
            responsiveWidth: responsiveWidth,
            responsiveHeight: responsiveWidth,
            onTap: savePhraseValue,
          ),
        ),
        PanelWidget(
          child: PhraseTypeButton(
            phraseNotifier: _phraseNotifier,
            buttonColor: const Color.fromARGB(255, 190, 255, 235),
            buttonphraseType: 'kind',
            responsiveWidth: responsiveWidth,
            responsiveHeight: responsiveWidth,
            onTap: savePhraseValue,
          ),
        ),
      ],
    );
  }
}
