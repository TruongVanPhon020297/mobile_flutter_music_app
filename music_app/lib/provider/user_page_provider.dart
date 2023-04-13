
import 'package:flutter/cupertino.dart';

import '../utils/database/database_helper.dart';
import '../model/song.dart';

class UserPageProvider extends ChangeNotifier {

  List<Song> allSongDatabase = [];

  void setAllSongDatabase(List<Song> list) {
    allSongDatabase = list;
  }

  Future<List<Song>> getAllSongDatabase() async {
    return await DatabaseHelper().getAllSongDatabase();
  }

}