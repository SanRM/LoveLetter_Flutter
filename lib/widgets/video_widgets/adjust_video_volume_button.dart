// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AjustVideoVolumeButton extends StatefulWidget {
  const AjustVideoVolumeButton(
      {required this.videoIsPlayingNotifier,
      required this.controller,
      super.key});

  final ValueNotifier<bool> videoIsPlayingNotifier;
  final YoutubePlayerController controller;

  @override
  State<AjustVideoVolumeButton> createState() => _AjustVideoVolumeButtonState();
}

class _AjustVideoVolumeButtonState extends State<AjustVideoVolumeButton> {

  double _currentVideoVolume = 20.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.videoIsPlayingNotifier,
        builder: (context, videoIsPlaying, child) {
          return Slider(
            value: _currentVideoVolume,
            min: 0,
            max: 100,
            thumbColor:  const Color.fromARGB(255, 150, 178, 255),
            activeColor: const Color.fromARGB(255, 141, 213, 255),
            inactiveColor: const Color.fromARGB(255, 241, 193, 255),
            onChanged: videoIsPlaying ? (value) {
              setState(() {
                _currentVideoVolume = value;
              });

              widget.controller.setVolume(
                _currentVideoVolume.toInt(),
              );

              if (_currentVideoVolume > 0) {
                widget.controller.unMute();
                //widget.videoIsPlayingNotifier.value = true;
              } else {
                widget.controller.mute();
                //widget.videoIsPlayingNotifier.value = false; 
              }
            } : null,
          );
        },
      ),
    );
  }

}
