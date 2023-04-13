import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:music_app/provider/user_page_provider.dart';
import 'package:music_app/views/play_list_page.dart';
import 'package:provider/provider.dart';

import '../model/position_data.dart';
import '../model/song.dart';
import '../provider/audio_player_provider.dart';
import '../provider/play_list_current_provider.dart';
import '../provider/play_list_page_provider.dart';
import '../provider/play_music_page_provider.dart';
import 'justautio/control_button_play_music_page.dart';
import 'justautio/seek_bar.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({super.key, required this.title});

  final String title;

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {

  int count = 1;

  bool favorite = false;

  bool play = false;

  PlayMusicPageProvider? playMusicPageProvider;

  @override
  void initState() {
    super.initState();

    playMusicPageProvider = Provider.of<PlayMusicPageProvider>(context,listen: false);

    IsolateNameServer.registerPortWithName(playMusicPageProvider!.downloadHelper.port.sendPort, 'downloader_send_port');

    playMusicPageProvider!.downloadHelper.registerCallback();
  }


  @override
  void dispose() {
    super.dispose();
    playMusicPageProvider!.downloadHelper.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer3<PlayListPageProvider,PlayListCurrentProvider,AudioPlayerProvider>(
        builder: (context, playListPageProvider,playListCurrentProvider,audioPlayerProvider,child) => Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Hero(
                tag: 'ssss',
                child: StreamBuilder<SequenceState?>(
                    stream: audioPlayerProvider.audioHelper.player.sequenceStateStream,
                    builder: (context, AsyncSnapshot<SequenceState?> snapshot) {
                      if (snapshot.data != null) {
                        return CachedNetworkImage(
                          imageUrl: audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].pictureBig,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30,left: 20,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(90 / 360),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
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
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Column(
                    children: const [
                      Text(
                        "But now I give up",
                        style: TextStyle(
                          color: Colors.white54
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Go easy on me, baby",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "I was still a child",
                        style: TextStyle(
                          color: Colors.white54
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: PlayMusicControl()
              )
            ],
          ),
        ),
      )
    );
  }
}

class PlayMusicControl extends StatelessWidget {
  const PlayMusicControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer6<PlayListPageProvider,PlayListCurrentProvider,AudioPlayerProvider,PlayMusicPageProvider,DownloadProvider,UserPageProvider>(
        builder: (context, playListPageProvider,playListCurrentProvider,audioPlayerProvider,playMusicPageProvider,downloadProvider,userPageProvider,child) => SizedBox(
        height: 310,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              height: 250,
              color: Colors.black.withOpacity(0.5),
              child: Column(
                children: [
                  StreamBuilder<SequenceState?>(
                    stream: audioPlayerProvider.audioHelper.player.sequenceStateStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {

                        playMusicPageProvider.setSongDownload(audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex]);

                        bool isDownload = false;

                        for (var element in userPageProvider.allSongDatabase) {
                          if(element.id == audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].id) {
                            isDownload = true;
                          }
                        }

                        return Container(
                          margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].songTitle,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 17
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].artistName,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 11
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children:[
                                  GestureDetector(
                                    onTap: () async{
                                      String path = await playMusicPageProvider.downloadHelper.download(
                                          playMusicPageProvider.songDownload!.preview
                                      );

                                      playMusicPageProvider.setPathSaveDataBase(path);

                                      playMusicPageProvider!.downloadHelper.port.listen((dynamic data) {
                                        String id = data[0];

                                        int status = data[1];

                                        int progress = data[2];

                                        if (status == 2) {

                                          print("RUNNING........................");

                                        } else if (status == 3) {

                                          print("COMPLETE........................");

                                          print("PATH  ----------- $path");

                                          Song songSaveDatabase = Song.allProperties(
                                              id: playMusicPageProvider.songDownload!.id,
                                              songTitle: playMusicPageProvider.songDownload!.songTitle,
                                              preview: playMusicPageProvider.pathSaveDataBase!,
                                              artistName:  playMusicPageProvider.songDownload!.artistName,
                                              pictureSmall:  playMusicPageProvider.songDownload!.pictureSmall,
                                              pictureMedium:  playMusicPageProvider.songDownload!.pictureMedium,
                                              pictureBig:  playMusicPageProvider.songDownload!.pictureBig
                                          );

                                          (() async {
                                            downloadProvider.setDownloadCompleted(await playMusicPageProvider.databaseHelper.insertTrack(songSaveDatabase));

                                            print("BOOL     -----------> ");

                                            userPageProvider.allSongDatabase.add(songSaveDatabase);

                                            Fluttertoast.showToast(
                                              msg: "Download complete!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );

                                          })();




                                        } else if (status == 4) {

                                          print("FAILED........................");


                                          Fluttertoast.showToast(
                                            msg: "Download failed!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );

                                        }
                                      });

                                    },
                                    child: isDownload ? const Icon(
                                      Icons.cloud_download,
                                      color: Color.fromRGBO(39, 184, 91, 1.0),
                                      size: 30,
                                    ) : const Icon(
                                      Icons.cloud_download,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }

                      return const CircularProgressIndicator();

                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: StreamBuilder<PositionData>(
                      stream: audioPlayerProvider.audioHelper.positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return SeekBar(
                          duration: positionData?.duration ?? Duration.zero,
                          position: positionData?.position ?? Duration.zero,
                          bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: (newPosition) {
                            audioPlayerProvider.audioPlayer!.seek(newPosition);
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: ControlButtonPlay(audioPlayerProvider.audioHelper.player!),
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white10,
                              offset: Offset(0,0)
                          )
                        ]
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayListPage(),
                        )
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://f4.bcbits.com/img/0016073391_10.jpg",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "From playlist",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      "Today's Top Hits",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

