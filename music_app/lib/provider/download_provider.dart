
import 'package:flutter/cupertino.dart';
import 'package:music_app/database/database_helper.dart';

import '../model/song.dart';

class DownloadProvider extends ChangeNotifier {

  bool downloadCompleted = false;

  void setDownloadCompleted(bool check) {
    downloadCompleted = check;
    notifyListeners();
  }

  Future<List<Song>> getAllSongProvider() async {
    return await DatabaseHelper().getAllSongDatabase();
  }

}