
import 'package:flutter/cupertino.dart';
import 'package:music_app/api/genre_song_api.dart';
import 'package:music_app/model/genre.dart';

import '../model/song.dart';

class PlayListPageProvider extends ChangeNotifier {

  late int playListId;

  late String playListImage;

  late String playListUrl;

  late String playListTitle;

  Future<List<Song>> getAllSongProvider() async {
    return await getAllSongByGenre(playListUrl);
  }

  void setPlayListInfo(int playListId,String playListImage,String playListUrl,String playListTitle) {
    this.playListId = playListId;
    this.playListImage = playListImage;
    this.playListUrl = playListUrl;
    this.playListTitle = playListTitle;
  }

}