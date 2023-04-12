
class Song {
  final int id;
  final String songTitle;
  final String preview;
  late String artistName;
  late String pictureSmall;
  late String pictureMedium;
  late String pictureBig;

  Song({
    required this.id,
    required this.songTitle,
    required this.preview,
  });

  Song.allProperties({
    required this.id,
    required this.songTitle,
    required this.preview,
    required this.artistName,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
  });
  
  factory Song.fromJson(Map<String,dynamic> json) {
    return Song(
        id: json['id'],
        songTitle: json['title'],
        preview: json['preview']
    );
  }

  void setArtistName(String artistName) {
    this.artistName = artistName;
  }

  void setPictureSmall(String pictureSmall) {
    this.pictureSmall = pictureSmall;
  }

  void setPictureMedium(String pictureMedium) {
    this.pictureMedium = pictureMedium;
  }

  void setPictureBig(String pictureBig) {
    this.pictureBig = pictureBig;
  }

  Map<String,dynamic> toMap() {
    return {
      'id' : id,
      'songTitle' : songTitle,
      'preview' : preview,
      'artistName' : artistName,
      'pictureSmall' : pictureSmall,
      'pictureMedium' : pictureMedium,
      'pictureBig' : pictureBig,
    };
  }

}