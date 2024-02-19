import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

enum ReproductionControllType { next, previous, stop }

class ReproductionVideoButton extends StatefulWidget {
  const ReproductionVideoButton(
      {required this.controller,
      required this.reproductionButtonType,
      required this.playlistLength,
      super.key});

  final YoutubePlayerController controller;
  final ReproductionControllType reproductionButtonType;
  final int playlistLength;
  //final Function() onTap;

  @override
  State<ReproductionVideoButton> createState() =>
      _ReproductionVideoButtonState();
}

class _ReproductionVideoButtonState extends State<ReproductionVideoButton> {
  final Color _backgroundbuttonColor = const Color.fromARGB(146, 255, 255, 255);
  bool _buttonIsHover = false;
  bool buttonIsSelected = false;
  bool videoIsPlaying = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          buttonActionOnTap();
          //widget.onTap();
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
                color: const Color.fromARGB(255, 97, 139, 255)),
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

    if (widget.reproductionButtonType == ReproductionControllType.next) {
      playNextVideo();

    } else if (widget.reproductionButtonType == ReproductionControllType.previous) {
      playPreviousVideo();

    } else {

      if (videoIsPlaying) {
        pauseVideo();

      } else {
        resumeVideo();

      }
    }
  }

  void resumeVideo() {
    setState(() {
      videoIsPlaying = true;
    });
    widget.controller.playVideo();
  }

  void pauseVideo() {
    setState(() {
      videoIsPlaying = false;
    });
    widget.controller.pauseVideo();
  }

  void playPreviousVideo() {
    showVideoIndex().then((value) => {
    
      if (value == 0){
        //print('video index: ${value}, la cantidad de videos es: ${widget.playlistLength}'),
        widget.controller.playVideoAt(widget.playlistLength - 1)
      } else {
        widget.controller.previousVideo()
      }
    
    });
  }

  void playNextVideo() {


    showVideoIndex().then((value) => {
    
      if (value + 1 == widget.playlistLength){
        //print('video index: ${value + 1}'),
        widget.controller.playVideoAt(0)
      } else {
        widget.controller.nextVideo()
      }
    
    });
  }

  showVideoIndex() async {
    var playlistIndex = await widget.controller.playlistIndex;
    return playlistIndex;
  }


  Icon buttonIcon() {
    if (widget.reproductionButtonType == ReproductionControllType.next) {
      return const Icon(
        Icons.skip_next_rounded,
        color: Color.fromARGB(255, 173, 195, 255),
      );
    } else if (widget.reproductionButtonType ==
        ReproductionControllType.previous) {
      return const Icon(
        Icons.skip_previous_rounded,
        color: Color.fromARGB(255, 173, 195, 255),
      );
    } else {
      if (videoIsPlaying) {
        return const Icon(
          Icons.pause,
          color: Color.fromARGB(255, 173, 195, 255),
        );
      } else {
        return const Icon(
          Icons.play_arrow_rounded,
          color: Color.fromARGB(255, 173, 195, 255),
        );
      }
    }
  }

  void _changeIfButtonIsHover({required bool state}) {
    setState(() {
      _buttonIsHover = state;
    });
  }
}
