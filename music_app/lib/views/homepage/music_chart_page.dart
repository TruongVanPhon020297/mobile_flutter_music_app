import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/album.dart';
import 'package:music_app/model/singer.dart';
import 'package:music_app/provider/music_chart_page_provider.dart';
import 'package:provider/provider.dart';

import 'album_top_chart_page_detail.dart';

class MusicChartPage extends StatefulWidget {
  const MusicChartPage({Key? key}) : super(key: key);

  @override
  State<MusicChartPage> createState() => _MusicChartPageState();
}

class _MusicChartPageState extends State<MusicChartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromRGBO(26, 27, 31, 1.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleMusicChartPage(),
            const MusicTopChartPage(),
            const ArtistTopChartPage(),
            const AlbumTopChartPage(),
            Container(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}

class TitleMusicChartPage extends StatelessWidget {
  const TitleMusicChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 50,bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hello Bambang!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Let's listen to something cool today",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                ),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 45,
              height: 45,
              color: const Color.fromRGBO(47, 48, 56, 1.0),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  const Icon(
                    Icons.add_alert_outlined,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        height: 7,
                        width: 7,
                        color: const Color.fromRGBO(38, 184, 91, 1.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MusicTopChartPage extends StatelessWidget {
  const MusicTopChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 10,top: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Top Music",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 350,
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                "https://www.musicgrotto.com/wp-content/uploads/2021/09/best-songs-of-all-time-graphic-art.jpg",
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AlbumTopChartPage extends StatelessWidget {
  const AlbumTopChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicChartPageProvider>(
      builder: (context, musicChartPageProvider, child) => Container(
        margin: const EdgeInsets.only(left: 20,right: 10,top: 40),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Top Album",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<Album>>(
                future: musicChartPageProvider.getAllTopAlbumProvider(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {

                    return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AlbumTopChartPageDetail(),
                                )
                              );

                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                snapshot.data![index].pictureMedium,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                        );
                      },
                    );

                  }

                  return const CircularProgressIndicator();
                },
              )
              ,
            )
          ],
        ),
      ),
    );
  }
}

class ArtistTopChartPage extends StatelessWidget {
  const ArtistTopChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicChartPageProvider>(
      builder: (context, musicChartPageProvider, child) => Container(
        margin: const EdgeInsets.only(left: 20,right: 10,top: 40),
        height: 150,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Top Singer",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Singer>>(
              future: musicChartPageProvider.getAllTopSingerProvider(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {

                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 70,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data![index].pictureMedium,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                snapshot.data![index].singerName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );

                }

                return const CircularProgressIndicator();

              },
            )
          ],
        ),
      ),
    );
  }
}





