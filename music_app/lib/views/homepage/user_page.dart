import 'package:flutter/material.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:provider/provider.dart';
import '../../model/song.dart';
import '../../provider/user_page_provider.dart';
import '../download_play_list_page.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DownloadProvider>(
      builder: (context, downloadProvider, child) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(26, 27, 31, 1.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleUserPage(),
              const GenrePage(),
              Container(
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TitleUserPage extends StatelessWidget {
  const TitleUserPage({Key? key}) : super(key: key);

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

class GenrePage extends StatelessWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer2<UserPageProvider,DownloadProvider>(
      builder: (context, userPageProvider,downloadProvider, child) => Container(
        margin: const EdgeInsets.only(left: 20,right: 10,top: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Downloaded music playlist",
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DownloadPlayListPage(),
                    )
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.redAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          width: 35,
                          height: 35,
                          color: Colors.yellow,
                          child: const Icon(
                              Icons.file_download_outlined
                          ),
                        ),
                      ),
                      const Text(
                        "Download",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),
                      FutureBuilder<List<Song>>(
                        future: userPageProvider.getAllSongDatabase(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {

                            userPageProvider.setAllSongDatabase(snapshot.data!);

                            List<int> listSongId = snapshot.data!.map((e) => e.id).toList();

                            userPageProvider.setListIdSongDatabase(listSongId);

                            return Text(
                                "${userPageProvider.allSongDatabase.length}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                )
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


