import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtonHomePage extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtonHomePage(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 35,
                ),
                iconSize: 35,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(
                  Icons.pause_circle_filled_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 35,
                ),
                iconSize: 35,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: Color.fromRGBO(39, 184, 91, 1.0),
                  size: 35,
                ),
                iconSize: 35,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 35
            ),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        )
      ],
    );
  }
}