import 'package:flutter/material.dart';
import 'package:music_app/model/genre.dart';
import 'package:music_app/provider/home_page_provider.dart';
import 'package:music_app/provider/play_list_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../provider/audio_player_provider.dart';
import '../play_list_page.dart';



class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromRGBO(26, 27, 31, 1.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitlePage(),
            const ArtistPage(),
            const GenrePage(),
            const MadeForYouPage(),
            Container(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}

class MadeForYouPage extends StatelessWidget {
  const MadeForYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<HomePageProvider,PlayListPageProvider,AudioPlayerProvider>(
      builder: (context, homePageProvider,playListPageProvider, audioPlayerProvider,child) => Container(
        margin: const EdgeInsets.only(left: 20,right: 10,top: 10),
        height: 200,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Made for you",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homePageProvider.dataWithMadeForYou.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 100,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            playListPageProvider.setPlayListInfo(
                                homePageProvider.dataWithMadeForYou[index].id,
                                homePageProvider.dataWithMadeForYou[index].pictureBig,
                                homePageProvider.dataWithMadeForYou[index].trackList,
                                homePageProvider.dataWithMadeForYou[index].title
                            );
                            audioPlayerProvider.setPlayListUrl(homePageProvider.dataWithMadeForYou[index].trackList);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const PlayListPage();
                                  },
                                )
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child:
                            CachedNetworkImage(
                              imageUrl: homePageProvider.dataWithMadeForYou[index].pictureMedium,
                              height: 200,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 80,
                          child: Text(
                            homePageProvider.dataWithMadeForYou[index].title,
                            style: const TextStyle(
                                fontFamily: "Til",
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


class TitlePage extends StatelessWidget {
  const TitlePage({Key? key}) : super(key: key);

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

class ArtistPage extends StatelessWidget {
  const ArtistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, homePageProvider, child) => Container(
        margin: const EdgeInsets.only(left: 20,right: 10),
        height: 150,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Your favorite artist",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homePageProvider.listArtist.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 70,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: CachedNetworkImage(
                            imageUrl: homePageProvider.listArtist[index].image,
                            height: 70,
                            width: 70,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          homePageProvider.listArtist[index].name,
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
            )
          ],
        ),
      ),
    );
  }
}

class GenrePage extends StatelessWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<HomePageProvider,PlayListPageProvider,AudioPlayerProvider>(
      builder: (context, homePageProvider,playListPageProvider,audioPlayerProvider, child) => Container(
        margin: const EdgeInsets.only(left: 20,right: 10,top: 10),
        height: 200,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recent played",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
            FutureBuilder<List<Genre>>(
              future: homePageProvider.getAllGenreProvider(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        return Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: GestureDetector(
                                  onTap: () {

                                    playListPageProvider.setPlayListInfo(
                                        snapshot.data![index].id,
                                        snapshot.data![index].pictureBig,
                                        snapshot.data![index].trackList,
                                        snapshot.data![index].title
                                    );

                                    audioPlayerProvider.setPlayListUrl(snapshot.data![index].trackList);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const PlayListPage();
                                          },
                                        )
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data![index].pictureMedium,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PlayListPage(),
                                      )
                                  );
                                },
                                child: Text(
                                  snapshot.data![index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Text("${snapshot.error}");
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



