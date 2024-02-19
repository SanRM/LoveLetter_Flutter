import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:project_a/widgets/video_widgets/adjust_video_volume_button.dart';
import 'package:project_a/widgets/video_widgets/mute_video_button.dart';
import 'package:project_a/widgets/panel.dart';
import 'package:project_a/widgets/phrase_manager/phrase_manager.dart';
import 'package:project_a/widgets/tooltip.dart';
import 'package:project_a/widgets/video_widgets/reproduction_constrolls.dart';
import 'package:project_a/data/api/youtube_api/youtube_api.dart';
import 'package:project_a/widgets/video_widgets/shuffle_button.dart';
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

    String message =
        '( ˘ ³˘)🤍 ¡En este día tan especial, quiero expresarte todo el amor y la ternura que siento por ti!. Eres la luz que ilumina mi vida, la razón de mi sonrisa y el latido de mi corazón, cada momento a tu lado es un regalo del cielo, y cada palabra que compartimos es una melodía de amor 🤍(ˆ⌣ˆԅ)ɔ. Te amo más allá de las palabras y deseo que este mensaje te llene de alegría y felicidad. ¡Eres mi todo!';

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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('background_images/wp2.jpg'),
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
                        const PanelWidget(
                          photo: 'decoration_images/deco1.jpeg',
                        ),
                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),
                        PanelWidget(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('background_images/wp4.jpg'),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const ModelViewer(
                                src: 'assets/scene.glb',
                                alt: "3D model",
                              ),
                            ),
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
                              const PanelWidget(
                                  flex: 2,
                                  photo: 'decoration_images/deco6.jpeg'),
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
                              const PanelWidget(
                                photo: 'decoration_images/deco7.jpeg',
                              ),

                              SizedBox(
                                width: responsiveWidth / 3.15,
                                child: Column(
                                  children: [
                                    PanelWidget(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'decoration_images/deco5.jpeg',
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
                              selectable: true,
                              style: TextStyle(
                                fontSize: responsiveHeight / 75,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'goudy',
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
                        const PanelWidget(
                          photo: 'decoration_images/deco2.jpeg',
                          flex: 4,
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: responsiveHeight / 13,
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
                          height: responsiveHeight / 13,
                          child: Row(
                            children: [
                              PanelWidget(
                                child: MuteVideoButton(
                                  videoIsPlayingNotifier:
                                      _videoIsPlayingNotifier,
                                  controller: _youtubePlayerController,
                                ),
                              ),
                              PanelWidget(
                                child: ShufflePlaylistButton(
                                  controller: _youtubePlayerController,
                                  playlistIsShuffle: _playlistIsShuffle,
                                  //playlistIsShuffle: _playlistIsShuffle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        PanelWidget(
                          child: AjustVideoVolumeButton(
                            videoIsPlayingNotifier: _videoIsPlayingNotifier,
                            controller: _youtubePlayerController,
                          ),
                        ),
                        SizedBox(
                          height: responsiveHeight * 0.01,
                        ),

                        //bottom panel
                        SizedBox(
                          width: double.infinity,
                          height: responsiveHeight / 13,
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
          mute: true, color: 'red', loop: true, showVideoAnnotations: false),
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
          playlistId: 'PLeTy2N15mY-sH9g20yn4hqtba7siPDrQv&si=EGUnc06sLBHBVQT8',
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
          playlistId: 'PLMaXlNzA5SDBuniEPDMz3Hlqsdb8UocIk&si=eyjKJJ8q5d4gzKYt',
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
          playlistId: 'PLMaXlNzA5SDD4wGRvVtcy3O2JKLiQkWkg&si=JSQRL47lmlFYtMgy',
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
