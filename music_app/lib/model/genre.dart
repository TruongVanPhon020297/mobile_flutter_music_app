
class Genre {

  late final int id;
  late String title;
  late final String pictureSmall;
  late final String pictureMedium;
  late final String pictureBig;
  late final String trackList;

  Genre({
    required this.id,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.trackList
  });

  Genre.genreInformation(int idGenre,String titleGenre,String pictureSmallGenre,String pictureMediumGenre,String pictureBigGenre,String trackListGenre) {
    id = idGenre;
    title = titleGenre;
    pictureSmall = pictureSmallGenre;
    pictureMedium = pictureMediumGenre;
    pictureBig = pictureBigGenre;
    trackList = trackListGenre;
  }

  factory Genre.fromJson(Map<String,dynamic> json) {
    return Genre(
        id: json['id'],
        pictureSmall: json['picture_small'],
        pictureMedium: json['picture_medium'],
        pictureBig: json['picture_big'],
        trackList: json['tracklist']
    );
  }

  void setTitle(String title) {
    this.title = title;
  }



}