
class Album {

  final int id;
  final String title;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String trackList;

  Album({
    required this.id,
    required this.title,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.trackList
  });

  factory Album.fromJson(Map<String,dynamic> json) {
    return Album(
        id: json['id'],
        title: json['title'],
        pictureSmall: json['cover_small'],
        pictureMedium: json['cover_medium'],
        pictureBig: json['cover_medium'],
        trackList: json['tracklist']
    );
  }

}