
import 'package:flutter/cupertino.dart';

import '../model/song.dart';

class PlayListCurrentProvider extends ChangeNotifier {

  int playListCurrentId = -1;

  List<Song>? listSongCurrent;

  void setPlayListCurrent(int id,List<Song> songs) {

    playListCurrentId = id;

    listSongCurrent = songs;

  }

  void setPlayListCurrentId(int id) {
    playListCurrentId = id;
  }

  void setListSongCurrent(List<Song> songs) {
    listSongCurrent = songs;
    notifyListeners();
  }

}