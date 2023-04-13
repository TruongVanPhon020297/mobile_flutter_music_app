
import 'package:flutter/cupertino.dart';
import 'package:music_app/utils/database/database_helper.dart';
import 'package:music_app/utils/download/download_helper.dart';
import 'package:music_app/model/song.dart';

class PlayMusicPageProvider extends ChangeNotifier {

  DownloadHelper downloadHelper = DownloadHelper();

  DatabaseHelper databaseHelper = DatabaseHelper();

  Song? songDownload;

  String? pathSaveDataBase;



  void setSongDownload(Song song) {
    songDownload = song;
  }

  void setPathSaveDataBase(String path) {
    pathSaveDataBase = path;
  }

}