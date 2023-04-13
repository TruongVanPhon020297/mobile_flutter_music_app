
import 'package:flutter/cupertino.dart';
import 'package:music_app/utils/database/database_helper.dart';

import '../model/song.dart';

class DownloadProvider extends ChangeNotifier {

  bool downloadCompleted = false;

  void setDownloadCompleted(bool check) {
    downloadCompleted = check;
    notifyListeners();
  }

}