import 'package:flutter/material.dart';
import 'package:project_a/widgets/panel.dart';
import 'package:project_a/data/api/youtube_api/youtube_api.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../config/config.dart';

enum PlaylistType {
  favorite,
  watchLater,
  history,
}

class PlaylistButton extends StatefulWidget {
  final ValueNotifier<List<String>> actualPlaylist;
  final YoutubeApi youtubeApiInstance;
  final Color buttonColor;
  final double responsiveHeight;
  final PlaylistType playlistType;
  final String playlistId;
  final Function() notifyParent;
  final ValueNotifier<bool> playlistIsShuffle;
  final YoutubePlayerController videoController;

  const PlaylistButton({
    super.key,
    required this.youtubeApiInstance,
    required this.buttonColor,
    required this.responsiveHeight,
    required this.playlistType,
    required this.playlistId,
    required this.actualPlaylist,
    required this.notifyParent,
    required this.playlistIsShuffle,
    required this.videoController,
  });

  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {

  late Color backgroundColor;
  late double iconPadding;

  @override
  void initState() {
    backgroundColor = widget.buttonColor;
    iconPadding = widget.responsiveHeight / 60;
    super.initState();
  }

  getFutureVideosIdInPlaylist() async {
    return await widget.youtubeApiInstance.getVideosIdInPlaylist(
      playListId: widget.playlistId,
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getFutureVideosIdInPlaylist(),
      builder: (context, snapshot) {

        return PanelWidget(
          child: InkWell(
            onTap: () {
              widget.actualPlaylist.value = snapshot.data as List<String>;
              widget.notifyParent();
              manageShuffle();
              showSnackBar(context);
              //print('La playlist actual es: ${widget.actualPlaylist.value}');
            },
            onHover: (value) {
              changeButtonColorOnHover(value);
              changeIconPaddingOnHover(value);
            },
            child: AnimatedContainer(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: backgroundColor,
              ),
              duration: const Duration(
                milliseconds: 250,
              ),
              child: Padding(
                padding: EdgeInsets.all(iconPadding),
                child: buttonIconByPlaylistType(),
              ),
            ),
          ),
        );
      },
    );
  }

  void manageShuffle() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (widget.playlistIsShuffle.value) {
        widget.videoController.setShuffle(shufflePlaylists: true);
      } else {
        widget.videoController.setShuffle(shufflePlaylists: false);
      }
    });
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        '¡Reproduciendo playlist ${renameButtonType()} 🤍!',
        style: TextStyle(
          fontFamily: fontFamily1,
          fontWeight: FontWeight.bold,
          fontSize: widget.responsiveHeight / 40,
          color: backgroundColor.darken(50),
        ),
      ),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  renameButtonType() {
    switch (widget.playlistType) {
      case PlaylistType.favorite:
        return 'rubí';
      case PlaylistType.history:
        return 'zafiro';
      default:
        return 'jade';
    }
  }

  Image buttonIconByPlaylistType() {
    switch (widget.playlistType) {
      case PlaylistType.favorite:
        return Image.asset(
          'button_icons/heart1.png',
        );
      case PlaylistType.history:
        return Image.asset(
          'button_icons/heart2.png',
        );
      default:
        return Image.asset(
          'button_icons/heart3.png',
        );
    }
  }

  void changeButtonColorOnHover(bool value) {
    if (value) {
      setState(
        () {
          backgroundColor = widget.buttonColor.darken(10);
        },
      );
    } else {
      setState(() {
        backgroundColor = widget.buttonColor;
      });
    }
  }
  
  void changeIconPaddingOnHover(bool value) {
    if (value) {
      setState(() {
        iconPadding = widget.responsiveHeight / 80;
      });
    } else {
      setState(() {
        iconPadding = widget.responsiveHeight / 60;
      });
    }
  }
}
