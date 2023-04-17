import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/model/singer.dart';

Future<List<Singer>> getAllTopSinger() async {

  String url = "https://api.deezer.com/chart/0/artists?index=5";

  var response = await http.get(Uri.parse(url));

  if(response.statusCode == 200) {

    var data = jsonDecode(response.body);

    List dataJson = data['data'];

    List<Singer> singers = dataJson.map((e) => Singer.fromJson(e)).toList();

    return singers;

  } else {

    throw Exception("Failed");

  }

}