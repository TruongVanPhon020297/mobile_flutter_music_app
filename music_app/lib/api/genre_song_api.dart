import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/model/song.dart';

Future<List<Song>> getAllSongByGenre(String url) async {

  var response = await http.get(Uri.parse(url));

  if(response.statusCode == 200) {

    var data = jsonDecode(response.body);

    List jsonData = data['data'];

    List<Song> songs = [];

    for (var element in jsonData) {
      Song song = Song.fromJson(element);

      var artist = element['artist'];
      
      song.setArtistName(artist['name']);

      var album = element['album'];
      
      song.setPictureSmall(album['cover_small']);
      
      song.setPictureMedium(album['cover_medium']);

      song.setPictureBig(album['cover_big']);

      songs.add(song);
      
    }

    return songs;

  } else {

    throw Exception("Failed");

  }

}