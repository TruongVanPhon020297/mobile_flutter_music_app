
class Singer {

  final int id;
  final String singerName;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String trackList;

  Singer({
    required this.id,
    required this.singerName,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.trackList
  });

  factory Singer.fromJson(Map<String,dynamic> json) {

    return Singer(
        id: json['id'],
        singerName: json['name'],
        pictureSmall: json['picture_small'],
        pictureMedium: json['picture_medium'],
        pictureBig: json['picture_big'],
        trackList: json['tracklist']
    );

  }
}