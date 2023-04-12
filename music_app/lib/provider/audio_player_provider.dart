import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/utils/justaudio/just_audio_helper.dart';
import '../api/genre_song_api.dart';

class AudioPlayerProvider extends ChangeNotifier {

  AudioPlayer? audioPlayer;

  AudioPlayer? audioPlayerCurrent;

  JustAudioHelper audioHelper = JustAudioHelper();

  String? playListUrl;

  List<Song>? listSongPlay = [];

  void setPlayListUrl(String url) {
    playListUrl = url;
  }

  void setAudioPlayer(AudioPlayer audioPlayer) {
    this.audioPlayer = audioPlayer;
  }

  void setAudioPlayerCurrent(AudioPlayer audioPlayer) {
    audioPlayerCurrent = audioPlayer;
  }

  void setListSongPlay(List<Song> songs) {
    listSongPlay = songs;
    notifyListeners();
  }


  Future<void> initPlayerController(String url) async{

    audioHelper.setAudioPlayer(audioPlayer!);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    List<Song> listSongPlay = await getAllSongByGenre(url);

    audioHelper.setPlayList(ConcatenatingAudioSource(children: [
      ...listSongPlay.map((e) => AudioSource.uri(
        Uri.parse(e.preview),
        tag: MediaItem(
          id: '${e.id}',
          album: e.artistName,
          title: e.songTitle,
          artUri: Uri.parse(
            e.pictureMedium
          ),
        )
      ),)
    ]));

    await audioHelper.initAudio();

  }

}