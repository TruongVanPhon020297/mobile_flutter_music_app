import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app/model/album.dart';

Future<List<Album>> getAllTopAlbum() async {

  String url = "https://api.deezer.com/chart/0/albums";

  var response = await http.get(Uri.parse(url));

  if(response.statusCode == 200) {

    var data = jsonDecode(response.body);
    
    List dataJson = data['data'];
    
    List<Album> albums = dataJson.map((e) => Album.fromJson(e)).toList();

    return albums;

  } else {

    throw Exception("Failed");

  }

}