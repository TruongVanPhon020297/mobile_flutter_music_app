import 'package:flutter/cupertino.dart';
import 'package:music_app/model/genre.dart';
import 'package:music_app/views/homepage/home_page_content.dart';
import 'package:music_app/views/homepage/music_chart_page.dart';
import 'package:music_app/views/homepage/search_page.dart';
import 'package:music_app/views/homepage/user_page.dart';

import '../api/genre_api.dart';
import '../model/artist.dart';
import '../views/play_list_page.dart';

class HomePageProvider extends ChangeNotifier {

  List<Artist> listArtist = [
    Artist(
        name: "Adele",
        image: "https://bazaarvietnam.vn/wp-content/uploads/2021/10/Adele-easy-on-me-8668-scaled-e1634283165498.jpg"
    ),
    Artist(
        name: "Ed Sheeran",
        image: "https://hips.hearstapps.com/hmg-prod/images/ed-sheeran-GettyImages-494227430_1600.jpg?resize=1200:*"
    ),
    Artist(
        name: "Justin Bieber",
        image: "https://media.gq.com/photos/56bcb218cdf2db6945d2ef93/master/pass/bieber-coverstory-square.jpg"
    ),
    Artist(
        name: "Charlie Puth",
        image: "https://znews-photo.zingcdn.me/w660/Uploaded/rohunaa/2022_10_21/z3817231801331_3479c6e3d82b019e950f464df0c562ba.jpg"
    ),
    Artist(
        name: "Adele",
        image: "https://bazaarvietnam.vn/wp-content/uploads/2021/10/Adele-easy-on-me-8668-scaled-e1634283165498.jpg"
    ),
    Artist(
        name: "Ed Sheeran",
        image: "https://hips.hearstapps.com/hmg-prod/images/ed-sheeran-GettyImages-494227430_1600.jpg?resize=1200:*"
    ),
    Artist(
        name: "Justin Bieber",
        image: "https://media.gq.com/photos/56bcb218cdf2db6945d2ef93/master/pass/bieber-coverstory-square.jpg"
    ),
    Artist(
        name: "Charlie Puth",
        image: "https://znews-photo.zingcdn.me/w660/Uploaded/rohunaa/2022_10_21/z3817231801331_3479c6e3d82b019e950f464df0c562ba.jpg"
    ),
  ];

  int navigatorBottomIndex = 0;

  List<SongData> listDataSong = [
    SongData(
        image: "https://bazaarvietnam.vn/wp-content/uploads/2021/10/Adele-easy-on-me-8668-scaled-e1634283165498.jpg",
        single: "Adele",
        nameSong: "Easy On Me"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/en/b/b0/Glass_Animals_-_Heat_Waves.png",
        single: "Gloss Animals",
        nameSong: "Heat Waves"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/vi/8/8d/CharliePuthSeeYouAgain.png",
        single: "Charlie Puth",
        nameSong: "See You Again"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/en/b/b0/Ed_Sheeran_-_Shivers.png",
        single: "Ed Sheeran",
        nameSong: "Shivers"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/vi/3/3d/Dua_Lipa_Levitating_%28DaBaby_Remix%29.png",
        single: "Dua Lipa",
        nameSong: "Levitating"
    ),
    SongData(
        image: "https://bazaarvietnam.vn/wp-content/uploads/2021/10/Adele-easy-on-me-8668-scaled-e1634283165498.jpg",
        single: "Adele",
        nameSong: "Easy On Me"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/en/b/b0/Glass_Animals_-_Heat_Waves.png",
        single: "Gloss Animals",
        nameSong: "Heat Waves"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/vi/8/8d/CharliePuthSeeYouAgain.png",
        single: "Charlie Puth",
        nameSong: "See You Again"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/en/b/b0/Ed_Sheeran_-_Shivers.png",
        single: "Ed Sheeran",
        nameSong: "Shivers"
    ),
    SongData(
        image: "https://upload.wikimedia.org/wikipedia/vi/3/3d/Dua_Lipa_Levitating_%28DaBaby_Remix%29.png",
        single: "Dua Lipa",
        nameSong: "Levitating"
    )
  ];

  List<Genre> dataWithMadeForYou = [
    Genre.genreInformation(
        1,
        "Top Hit",
        "https://img.freepik.com/free-psd/3d-render-portable-radio-icon_439185-12461.jpg?w=56",
        "https://img.freepik.com/free-psd/3d-render-portable-radio-icon_439185-12461.jpg?w=250",
        "https://img.freepik.com/free-psd/3d-render-portable-radio-icon_439185-12461.jpg?w=500",
        "https://api.deezer.com/chart/0/tracks"
    ),
    Genre.genreInformation(
        2,
        "Chillies",
        "https://e-cdns-images.dzcdn.net/images/artist/ff5dda5f23332bcf6fa2543ca9a3385e/56x56-000000-80-0-0.jpg",
        "https://e-cdns-images.dzcdn.net/images/artist/ff5dda5f23332bcf6fa2543ca9a3385e/250x250-000000-80-0-0.jpg",
        "https://e-cdns-images.dzcdn.net/images/artist/ff5dda5f23332bcf6fa2543ca9a3385e/500x500-000000-80-0-0.jpg",
        "https://api.deezer.com/artist/53412882/top?limit=50"
    ),
    Genre.genreInformation(
        3,
        "Acoustic",
        "https://e-cdns-images.dzcdn.net/images/artist/01a7af1ca066585c9f212f06cda76376/56x56-000000-80-0-0.jpg",
        "https://e-cdns-images.dzcdn.net/images/artist/01a7af1ca066585c9f212f06cda76376/250x250-000000-80-0-0.jpg",
        "https://e-cdns-images.dzcdn.net/images/artist/01a7af1ca066585c9f212f06cda76376/500x500-000000-80-0-0.jpg",
        "https://api.deezer.com/artist/14470049/top?limit=50"
    ),

    Genre.genreInformation(
        4,
        "Chill",
        "https://e-cdns-images.dzcdn.net/images/artist/49a11184f1e4e406731c54de5e75a899/56x56-000000-80-0-0.jpg",
        "https://e-cdns-images.dzcdn.net/images/artist/49a11184f1e4e406731c54de5e75a899/250x250-000000-80-0-0.jpg",
        "https://e-cdns-images.dzcdn.net/images/artist/49a11184f1e4e406731c54de5e75a899/500x500-000000-80-0-0.jpg",
        "https://api.deezer.com/artist/8979084/top?limit=50"
    ),

  ];

  final List<Widget> screens = <Widget>[
    const HomePageContent(),
    const SearchPage(),
    const MusicChartPage(),
    const UserPage()
  ];

  Future<List<Genre>> getAllGenreProvider() async {
    return await getAllGenre();
  }

  void setNavigatorBottomIndex(int index) {
    navigatorBottomIndex = index;
    notifyListeners();
  }

}