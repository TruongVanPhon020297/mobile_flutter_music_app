
class SongTopAlbum {

  final int id;
  final String title;
  final String preview;
  late String artistName;

  SongTopAlbum({
   required this.id,
   required this.title,
    required this.preview
  });

  void setArtistName(String artistName) {
    this.artistName = artistName;
  }

  factory SongTopAlbum.fromJson(Map<String,dynamic> json) {
    return SongTopAlbum(
        id: json['id'],
        title: json['title'],
        preview: json['preview']
    );
  }

}