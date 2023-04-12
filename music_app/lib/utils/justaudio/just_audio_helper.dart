import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/position_data.dart';


class JustAudioHelper {

  AudioPlayer? player;

  ConcatenatingAudioSource? playlist;

  void setAudioPlayer(AudioPlayer audioPlayer) {
    player = audioPlayer;
  }


  Future<void> initAudio() async {
    player!.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      await player!.setAudioSource(playlist!,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player!.positionStream,
          player!.bufferedPositionStream,
          player!.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  get getPlayList => playlist;

  get getPlayer => player;

  void setPlayList(ConcatenatingAudioSource audioSource) {
    playlist = audioSource;
  }

  void dispose() {
    player!.dispose();
  }

}