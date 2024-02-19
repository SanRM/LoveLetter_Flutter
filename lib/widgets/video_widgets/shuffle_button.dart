// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ShufflePlaylistButton extends StatefulWidget {
  const ShufflePlaylistButton({
    required this.controller,
    required this.playlistIsShuffle,
    super.key,
  });

  final YoutubePlayerController controller;
  final ValueNotifier playlistIsShuffle;

  @override
  State<ShufflePlaylistButton> createState() => _ShufflePlaylistButtonState();
}

class _ShufflePlaylistButtonState extends State<ShufflePlaylistButton> {
  Color _backgroundbuttonColor = const Color.fromARGB(146, 255, 255, 255);
  bool _buttonIsHover = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          shufflePlaylist();
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
        child: AnimatedContainer(
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
          child: widget.playlistIsShuffle.value
              ? const Icon(
                  Icons.shuffle,
                  color: Color.fromARGB(255, 255, 255, 255),
                )
              : const Icon(
                  Icons.shuffle,
                  color: Color.fromARGB(255, 173, 195, 255),
                ),
        ),
      ),
    );
  }

  void shufflePlaylist() {
    if (widget.playlistIsShuffle.value) {
      setState(() {
        widget.playlistIsShuffle.value = false;
        widget.controller.setShuffle(shufflePlaylists: false);
        _changeBackgroundButtonColor(
            newColor: const Color.fromARGB(255, 255, 255, 255));
      });
    } else {
      setState(() {
        widget.playlistIsShuffle.value = true;
        widget.controller.setShuffle(shufflePlaylists: true);
        _changeBackgroundButtonColor(
            newColor: const Color.fromARGB(255, 173, 195, 255));
      });
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
