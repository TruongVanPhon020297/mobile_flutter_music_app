
import 'package:flutter/cupertino.dart';

import '../utils/database/database_helper.dart';
import '../model/song.dart';

class UserPageProvider extends ChangeNotifier {

  List<Song> allSongDatabase = [];

  List<int> listIdSongDatabase = [];

  void setAllSongDatabase(List<Song> list) {
    allSongDatabase = list;
  }

  void setListIdSongDatabase(List<int> list) {
    listIdSongDatabase = list;
  }

  Future<List<Song>> getAllSongDatabase() async {
    return await DatabaseHelper().getAllSongDatabase();
  }

}