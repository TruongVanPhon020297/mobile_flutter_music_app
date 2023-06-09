import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButton extends StatelessWidget {

  AudioPlayer? player;

  AudioPlayer? currentPlayer;

  ControlButton({required this.player,required this.currentPlayer, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        player == currentPlayer ? StreamBuilder<PlayerState>(
          stream: player!.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 60,
                ),
                iconSize: 64.0,
                onPressed: player!.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(
                  Icons.pause_circle_filled_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 60,
                ),
                iconSize: 64.0,
                onPressed: player!.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 60,
                ),
                iconSize: 60.0,
                onPressed: () => player!.seek(Duration.zero,),
              );
            }
          },
        ) : StreamBuilder<PlayerState>(
          stream: player!.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 60,
                ),
                iconSize: 64.0,
                onPressed: player!.play,
              );
            } else if (processingState != ProcessingState.completed) {

              if(currentPlayer != null) {
                currentPlayer!.dispose();
              }

              return IconButton(
                icon: const Icon(
                  Icons.pause_circle_filled_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 60,
                ),
                iconSize: 64.0,
                onPressed: player!.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 60,
                ),
                iconSize: 60.0,
                onPressed: () => player!.seek(Duration.zero,),
              );
            }
          },
        )
      ],
    );
  }
}