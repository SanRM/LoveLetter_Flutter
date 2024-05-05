import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../config/config.dart';

enum ReproductionControllType {
  next,
  previous,
  stop,
  home,
  mute,
  shuffle,
  volume
}

class ReproductionVideoButton extends StatefulWidget {
  const ReproductionVideoButton(
      {required this.controller,
      required this.reproductionButtonType,
      required this.playlistLength,
      this.videoIsPlayingNotifier,
      this.playlistIsShuffle,
      super.key});

  final YoutubePlayerController controller;
  final ReproductionControllType reproductionButtonType;
  final ValueNotifier<bool>? videoIsPlayingNotifier;
  final ValueNotifier<bool>? playlistIsShuffle;
  final int playlistLength;

  @override
  State<ReproductionVideoButton> createState() =>
      _ReproductionVideoButtonState();
}

class _ReproductionVideoButtonState extends State<ReproductionVideoButton> {
  bool _buttonIsHover = false;
  bool _videoIsPlaying = true;
  Color _backgroundbuttonColor = const Color.fromARGB(146, 255, 255, 255);
  double _currentVideoVolume = 20.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          buttonActionOnTap();
        },
        onHover: (value) {
          if (ReproductionControllType.volume != widget.reproductionButtonType) {
            if (value) {
              _changeIfButtonIsHover(state: true);
            } else {
              _changeIfButtonIsHover(state: false);
            }
          }
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              width: _buttonIsHover ? 3 : 1,
              color: _buttonIsHover ? enfasisColorLight : Colors.transparent,
            ),
            color: _backgroundbuttonColor,
          ),
          duration: const Duration(
            milliseconds: 250,
          ),
          child: buttonIcon(),
        ),
      ),
    );
  }

  void buttonActionOnTap() {
    switch (widget.reproductionButtonType) {
      case ReproductionControllType.next:
        _playNextVideoOnTap();
        break;

      case ReproductionControllType.previous:
        _playPreviousVideoOnTap();
        break;

      case ReproductionControllType.home:
        _homeVideoOnTap();
        break;

      case ReproductionControllType.mute:
        _muteVideoOnTap();
        break;

      case ReproductionControllType.shuffle:
        _shufflePlaylistOnTap();
        break;

      case ReproductionControllType.volume:
        _adjustVolumeOnTap();
        break;

      default:
        _playOrPauseVideoOnTap();
    }
  }

  Widget buttonIcon() {
    switch (widget.reproductionButtonType) {
      case ReproductionControllType.next:
        return _nextVideoIcon();

      case ReproductionControllType.previous:
        return _previousVideoIcon();

      case ReproductionControllType.mute:
        return _muteVideoIcon();

      case ReproductionControllType.home:
        return _homeVideoIcon();

      case ReproductionControllType.shuffle:
        return _shufflePlaylistIcon();

      case ReproductionControllType.volume:
        return _adjustVolumeWidget();

      default:
        return _pauseAndPlayButton();
    }
  }

  Icon _pauseAndPlayButton() {
    if (_videoIsPlaying) {
      return Icon(Icons.pause, color: enfasisColorLight);
    } else {
      return Icon(
        Icons.play_arrow_rounded,
        color: enfasisColorLight,
      );
    }
  }

  Icon _homeVideoIcon() {
    return Icon(
      Icons.home_filled,
      color: enfasisColorLight,
    );
  }

  ValueListenableBuilder<bool> _muteVideoIcon() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.videoIsPlayingNotifier!,
      builder: (context, videoIsPlaying, child) {
        if (videoIsPlaying) {
          Future.delayed(Duration.zero, () {
            _changeBackgroundButtonColor(newColor: enfasisColorLight);
          });
          return const Icon(
            Icons.volume_up,
            color: Colors.white,
          );
        } else {
          Future.delayed(Duration.zero, () {
            _changeBackgroundButtonColor(newColor: Colors.white);
          });
          return Icon(
            Icons.volume_off,
            color: enfasisColorLight,
          );
        }
      },
    );
  }

  ValueListenableBuilder<bool> _shufflePlaylistIcon() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.playlistIsShuffle!,
      builder: (context, videoIsPlaying, child) {
        if (videoIsPlaying) {
          Future.delayed(Duration.zero, () {
            _changeBackgroundButtonColor(newColor: enfasisColorLight);
          });
          return const Icon(
            Icons.shuffle,
            color: Colors.white,
          );
        } else {
          Future.delayed(Duration.zero, () {
            _changeBackgroundButtonColor(newColor: Colors.white);
          });
          return Icon(
            Icons.shuffle,
            color: enfasisColorLight,
          );
        }
      },
    );
  }

  Icon _previousVideoIcon() {
    return Icon(
      Icons.skip_previous_rounded,
      color: enfasisColorLight,
    );
  }

  Icon _nextVideoIcon() {
    return Icon(
      Icons.skip_next_rounded,
      color: enfasisColorLight,
    );
  }

  Widget _adjustVolumeWidget() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.videoIsPlayingNotifier!,
      builder: (context, videoIsPlaying, child) {
        return Slider(
          value: _currentVideoVolume,
          min: 0,
          max: 100,
          thumbColor: const Color.fromARGB(255, 150, 178, 255),
          activeColor: const Color.fromARGB(255, 141, 213, 255),
          inactiveColor: const Color.fromARGB(255, 241, 193, 255),
          onChanged: videoIsPlaying
              ? (value) {
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
                }
              : null,
        );
      },
    );
  }

  void resumeVideo() {
    setState(() {
      _videoIsPlaying = true;
    });
    widget.controller.playVideo();
  }

  void pauseVideo() {
    setState(() {
      _videoIsPlaying = false;
    });
    widget.controller.pauseVideo();
  }

  void _playPreviousVideoOnTap() {
    showVideoIndex().then(
      (value) => {
        if (value == 0)
          {widget.controller.playVideoAt(widget.playlistLength - 1)}
        else
          {widget.controller.previousVideo()}
      },
    );
  }

  void _playNextVideoOnTap() {
    showVideoIndex().then(
      (value) => {
        if (value + 1 == widget.playlistLength)
          {widget.controller.playVideoAt(0)}
        else
          {widget.controller.nextVideo()}
      },
    );
  }

  showVideoIndex() async {
    var playlistIndex = await widget.controller.playlistIndex;
    return playlistIndex;
  }

  void _homeVideoOnTap() {
    widget.controller.loadVideoById(videoId: 'jfKfPfyJRdk');
  }

  void _muteVideoOnTap() {
    if (widget.videoIsPlayingNotifier?.value == true) {
      widget.controller.mute();
      widget.videoIsPlayingNotifier?.value = false;
    } else {
      widget.controller.unMute();
      widget.videoIsPlayingNotifier?.value = true;
    }
  }

  void _playOrPauseVideoOnTap() {
    if (_videoIsPlaying) {
      pauseVideo();
    } else {
      resumeVideo();
    }
  }

  void _shufflePlaylistOnTap() {
    if (widget.playlistIsShuffle!.value) {
      widget.playlistIsShuffle!.value = false;
      widget.controller.setShuffle(shufflePlaylists: false);
      _changeBackgroundButtonColor(newColor: Colors.white);
    } else {
      widget.playlistIsShuffle!.value = true;
      widget.controller.setShuffle(shufflePlaylists: true);
      _changeBackgroundButtonColor(newColor: enfasisColorLight);
    }
  }

  void _adjustVolumeOnTap() {
    return;
  }

  void _changeIfButtonIsHover({required bool state}) {
    setState(() => _buttonIsHover = state);
  }

  void _changeBackgroundButtonColor({required Color newColor}) {
    setState(() => _backgroundbuttonColor = newColor);
  }
}
