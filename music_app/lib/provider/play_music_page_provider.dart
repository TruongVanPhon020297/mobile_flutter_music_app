
import 'package:flutter/cupertino.dart';
import 'package:music_app/database/database_helper.dart';
import 'package:music_app/download/download_helper.dart';
import 'package:music_app/model/song.dart';

class PlayMusicPageProvider extends ChangeNotifier {

  DownloadHelper downloadHelper = DownloadHelper();

  DatabaseHelper databaseHelper = DatabaseHelper();

  Song? songDownload;

  void setSongDownload(Song song) {
    songDownload = song;
  }

}