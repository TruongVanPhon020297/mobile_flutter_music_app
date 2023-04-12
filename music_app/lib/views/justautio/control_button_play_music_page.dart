import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtonPlay extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtonPlay(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            StreamBuilder<LoopMode>(
              stream: player.loopModeStream,
              builder: (context, snapshot) {
                final loopMode = snapshot.data ?? LoopMode.off;
                const icons = [
                  Icon(Icons.repeat, color: Colors.grey,size: 40,),
                  Icon(Icons.repeat, color: Color.fromRGBO(39, 184, 91, 1.0),size: 40,),
                  Icon(Icons.repeat_one, color: Color.fromRGBO(39, 184, 91, 1.0),size: 40,),
                ];
                const cycleModes = [
                  LoopMode.off,
                  LoopMode.all,
                  LoopMode.one,
                ];
                final index = cycleModes.indexOf(loopMode);
                return IconButton(
                  icon: icons[index],
                  onPressed: () {
                    player.setLoopMode(cycleModes[
                    (cycleModes.indexOf(loopMode) + 1) %
                        cycleModes.length]);
                  },
                );
              },
            ),
          ],
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 40,
            ),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_circle_fill_outlined),
                iconSize: 60.0,
                onPressed: player.play,
                color: const Color.fromRGBO(39, 184, 91, 1.0),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause_circle_filled_outlined),
                iconSize: 60.0,
                onPressed: player.pause,
                color: const Color.fromRGBO(39, 184, 91, 1.0),
              );
            } else {
              player.pause();
              player.seek(Duration.zero);
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
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
                size: 40
            ),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        StreamBuilder<bool>(
          stream: player.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            final shuffleModeEnabled = snapshot.data ?? false;
            return IconButton(
              icon: shuffleModeEnabled
                  ? const Icon(Icons.shuffle,color: Color.fromRGBO(39, 184, 91, 1.0),size: 40,)
                  : const Icon(Icons.shuffle, color: Colors.grey,size: 40,),
              onPressed: () async {
                final enable = !shuffleModeEnabled;
                if (enable) {
                  await player.shuffle();
                }
                await player.setShuffleModeEnabled(enable);
              },
            );
          },
        ),
      ],
    );
  }
}