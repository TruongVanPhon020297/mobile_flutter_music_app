import 'package:flutter/material.dart';
import 'package:music_app/database/database_helper.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:provider/provider.dart';

import '../../model/song.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadProvider>(
      builder: (context, downloadProvider, child) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Song>>(
                future: downloadProvider.getAllSongProvider(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 0.3,),
                        padding: const EdgeInsets.only(left: 20),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration:const BoxDecoration(
                            color: Color.fromRGBO(
                                26, 27, 31, 1.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white54,
                                  offset: Offset(0,0.3)
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration:BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data![index].pictureMedium
                                            )
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: GestureDetector(
                                      onTap: (){

                                      },
                                      child: const Icon(
                                        Icons.play_arrow_sharp,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot.data![index].songTitle,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].artistName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Color.fromRGBO(39, 183, 90, 1.0),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20,right: 20),
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else if(snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
