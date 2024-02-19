// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MuteVideoButton extends StatefulWidget {
  const MuteVideoButton(
      {required this.videoIsPlayingNotifier,
      required this.controller,
      super.key});

  final ValueNotifier<bool> videoIsPlayingNotifier;
  final YoutubePlayerController controller;

  @override
  State<MuteVideoButton> createState() => _MuteVideoButtonState();
}

class _MuteVideoButtonState extends State<MuteVideoButton> {
  Color _backgroundbuttonColor = const Color.fromARGB(146, 255, 255, 255);
  bool _buttonIsHover = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          muteVideo();
        },
        onHover: (value) {
          if (value) {
            _changeIfButtonIsHover(state: true);
            //print('hovering');
          } else {
            _changeIfButtonIsHover(state: false);
            //print('not hovering');
          }
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.videoIsPlayingNotifier,
          builder: (context, videoIsPlaying, child) {
            return AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    width: _buttonIsHover ? 2 : 1,
                    color: Color.fromARGB(255, 97, 139, 255)),
                color: _backgroundbuttonColor,
              ),
              duration: const Duration(
                milliseconds: 250,
              ),
              child: videoIsPlaying
                  ? const Icon(
                      Icons.volume_up,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )
                  : const Icon(
                      Icons.volume_off,
                      color: Color.fromARGB(255, 173, 195, 255),
                    ),
            );
          },
        ),
      ),
    );
  }

  void muteVideo() {

    if (widget.videoIsPlayingNotifier.value) {
      widget.controller.mute();
      widget.videoIsPlayingNotifier.value = false;
      _changeBackgroundButtonColor(newColor: const Color.fromARGB(255, 255, 255, 255));
    } else {
      widget.controller.unMute();
      widget.videoIsPlayingNotifier.value = true;
      _changeBackgroundButtonColor(newColor: const Color.fromARGB(255, 173, 195, 255));
    }

  }

  void _changeBackgroundButtonColor({required Color newColor}) =>
      _backgroundbuttonColor = newColor;

  void _changeIfButtonIsHover({required bool state}) {
    setState(() {
      _buttonIsHover = state;
    });
  }
}
