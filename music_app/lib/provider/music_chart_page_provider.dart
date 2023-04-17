
import 'package:flutter/cupertino.dart';
import 'package:music_app/api/singer_api.dart';
import 'package:music_app/model/album.dart';
import 'package:music_app/model/singer.dart';
import '../api/album_api.dart';

class MusicChartPageProvider extends ChangeNotifier {

  Future<List<Album>> getAllTopAlbumProvider() async {
    return await getAllTopAlbum();
  }

  Future<List<Singer>> getAllTopSingerProvider() async {
    return await getAllTopSinger();
  }

}