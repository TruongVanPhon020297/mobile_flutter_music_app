import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app/model/genre.dart';

Future<List<Genre>> getAllGenre() async {

  String url = "https://api.deezer.com/radio/genres";

  var response = await http.get(Uri.parse(url));

  if(response.statusCode == 200) {

    var data = jsonDecode(response.body);

    List dataJson = data['data'];

    List<Genre> genres = [];

    for (var element in dataJson) {

      List dataRadios = element['radios'];

      Genre genre = Genre.fromJson(dataRadios.first);

      genre.setTitle(element['title']);

      genres.add(genre);

    }

    return genres;

  } else {

    throw Exception("Failed");

  }


}