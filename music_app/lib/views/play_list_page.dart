import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/provider/play_list_current_provider.dart';
import 'package:music_app/provider/play_list_page_provider.dart';
import 'package:music_app/views/justautio/control_button.dart';
import 'package:provider/provider.dart';

import '../model/position_data.dart';
import '../model/song.dart';
import '../provider/audio_player_provider.dart';
import '../provider/user_page_provider.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class SongData {
  
  final String image;
  final String single;
  final String nameSong;
  
  SongData({required this.image,required this.single,required this.nameSong});
  
}

class _PlayListPageState extends State<PlayListPage> with WidgetsBindingObserver{

  int count = 0;

  bool flag = false;

  List listFavorite = [];

  bool check = false;

  bool isPlay = false;

  List playList = [0];

  bool checkPlay = false;

  bool favoritePlayList = false;

  bool isLoading = false;

  List<Song> listSongTemp = [];

  List<Song> listSongPlay = [];

  int idTemp = -1;

  List<Song>? listSongInitController;

  @override
  void initState() {
    super.initState();

    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context,listen: false);
    var playListCurrentProvider = Provider.of<PlayListCurrentProvider>(context,listen: false);
    var playListPageProvider = Provider.of<PlayListPageProvider>(context,listen: false);

    ambiguate(WidgetsBinding.instance)!.addObserver(this);

    if(playListCurrentProvider.playListCurrentId == -1) {

      (()async{

        listSongInitController = await playListPageProvider.getAllSongProvider();

        audioPlayerProvider.audioHelper.initAudio(audioPlayerProvider.initListSongForPlayerController(listSongInitController!));

        setState(() {
          isLoading = true;
        });

      })();

    } else if(playListPageProvider.playListId == playListCurrentProvider.playListCurrentId) {


      isLoading = true;

      listSongTemp = playListCurrentProvider.listSongCurrent!;

      idTemp = playListCurrentProvider.playListCurrentId!;

    } else {

      listSongTemp = playListCurrentProvider.listSongCurrent!;

      idTemp = playListCurrentProvider.playListCurrentId!;

      (()async{

        listSongInitController = await playListPageProvider.getAllSongProvider();


        audioPlayerProvider.audioHelper.initAudio(audioPlayerProvider.initListSongForPlayerController(listSongInitController!));

        setState(() {
          isLoading = true;
        });

      })();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer4<PlayListPageProvider,PlayListCurrentProvider,AudioPlayerProvider,UserPageProvider>(
      builder: (context, playListPageProvider,playListCurrentProvider,audioPlayerProvider,userPageProvider,child) => Scaffold(
          backgroundColor: const Color.fromRGBO(26, 27, 31, 1.0),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 450,
                color: const Color.fromRGBO(26, 27, 31, 1.0),
                child: Stack(
                  children: [
                    Image.network(
                      playListPageProvider.playListImage,
                      width:MediaQuery.of(context).size.width,
                      height: 400,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 20,
                      child: ControlButton(player: audioPlayerProvider.audioHelper.player),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TODAY'S",
                            style: TextStyle(
                                fontFamily: "Lon",
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            playListPageProvider.playListTitle,
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30,left: 20,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          GestureDetector(
                            onTap: () {

                              if(audioPlayerProvider.audioPlayerCurrent == null) {
                                audioPlayerProvider.setListSongPlay(listSongInitController!);
                              } else if(playListPageProvider.playListId != idTemp && audioPlayerProvider.audioPlayer!.playing == false) {
                                playListCurrentProvider.setPlayListCurrent(idTemp, listSongTemp);
                                audioPlayerProvider.setListSongPlay(listSongTemp);
                              } else if(playListPageProvider.playListId != idTemp && audioPlayerProvider.audioPlayer!.playing == true) {
                                audioPlayerProvider.setListSongPlay(listSongPlay);
                              } else {
                                audioPlayerProvider.setListSongPlay(listSongTemp);
                              }

                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children:[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    favoritePlayList = !favoritePlayList;
                                  });
                                },
                                child: Icon(
                                  favoritePlayList ? Icons.favorite : Icons.favorite_border_outlined,
                                  color: favoritePlayList ? const Color.fromRGBO(39, 183, 90, 1.0) : Colors.white,
                                  size: 30,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Row(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "35,498,726",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "likes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.watch_later,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "2h 36min",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Featuring",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                        ),
                      ),

                      playListPageProvider.playListId != playListCurrentProvider.playListCurrentId ?

                      StreamBuilder<SequenceState?>(
                        stream: audioPlayerProvider.audioHelper.player.sequenceStateStream,
                        builder: (context,AsyncSnapshot<SequenceState?> snapshotState) {
                          if(snapshotState.hasData && isLoading) {
                            return Expanded(
                                child: ListView.builder(
                                  itemCount: listSongInitController!.length,
                                  itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.only(bottom: 0.3,),
                                    padding: const EdgeInsets.only(left: 20),
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    decoration:BoxDecoration(
                                        color: snapshotState.data!.currentIndex == index ? const Color.fromRGBO(
                                            38, 39, 42, 1.0) : const Color.fromRGBO(
                                            26, 27, 31, 1.0),
                                        boxShadow: const [
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
                                                            listSongInitController![index].pictureMedium
                                                        )
                                                    ),
                                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                                ),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    checkPlay = playList.contains(index);
                                                    if(checkPlay){
                                                      playList.remove(index);
                                                    } else {
                                                      playList.clear();
                                                      playList.add(index);
                                                    }

                                                    if(snapshotState.data!.currentIndex != index){
                                                      audioPlayerProvider.audioHelper.player.seek(Duration.zero, index: index);
                                                      if(!audioPlayerProvider.audioHelper.player.playing){
                                                        audioPlayerProvider.audioHelper.player.play();
                                                      }
                                                    } else {
                                                      if(audioPlayerProvider.audioHelper.player.playing) {
                                                        audioPlayerProvider.audioHelper.player.pause();
                                                      } else {
                                                        audioPlayerProvider.audioHelper.player.play();
                                                      }
                                                    }
                                                  },
                                                  child: StreamBuilder<PlayerState>(
                                                    stream: audioPlayerProvider.audioHelper.player.playerStateStream,
                                                    builder: (context, snapshot) {
                                                      return Icon(
                                                        playList.contains(index) &&  audioPlayerProvider.audioHelper.player.playing  ? Icons.pause : Icons.play_arrow_sharp,
                                                        size: 35,
                                                        color: playList.contains(index) ? Colors.white : Colors.white70,
                                                      );
                                                    },
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
                                                        listSongInitController![index].songTitle,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                      Text(
                                                        listSongInitController![index].artistName,
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
                                          children:[
                                            Container(
                                              margin: const EdgeInsets.only(right: 20),
                                              child: GestureDetector(
                                                onTap: (){
                                                  print("SONG ID --------------> ${listSongInitController![index].id}");
                                                },
                                                child: userPageProvider.listIdSongDatabase.contains(listSongInitController![index].id) ? const Icon(
                                                  Icons.cloud_download,
                                                  color: Color.fromRGBO(39, 184, 91, 1.0),
                                                  size: 30,
                                                ) : const Icon(
                                                  Icons.cloud_download,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      )
                          : Expanded(
                          child: StreamBuilder<SequenceState?>(
                                  stream: audioPlayerProvider.audioHelper.player.sequenceStateStream,
                                  builder: (context,AsyncSnapshot<SequenceState?> snapshot) {
                                    if(snapshot.hasData) {

                                      playList.clear();

                                      playList.add(snapshot.data!.currentIndex);

                                      return ListView.builder(
                                        itemCount: playListCurrentProvider.listSongCurrent!.length,
                                        itemBuilder: (context, index) => Container(
                                          margin: const EdgeInsets.only(bottom: 0.3,),
                                          padding: const EdgeInsets.only(left: 20),
                                          height: 80,
                                          width: MediaQuery.of(context).size.width,
                                          decoration:BoxDecoration(
                                              color: snapshot.data!.currentIndex == index ? const Color.fromRGBO(
                                                  38, 39, 42, 1.0) : const Color.fromRGBO(
                                                  26, 27, 31, 1.0),
                                              boxShadow: const [
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
                                                                  playListCurrentProvider.listSongCurrent![index].pictureMedium
                                                              )
                                                          ),
                                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                            checkPlay = playList.contains(index);
                                                            if(checkPlay){
                                                              playList.remove(index);
                                                            } else {
                                                              playList.clear();
                                                              playList.add(index);
                                                            }

                                                            if(snapshot.data!.currentIndex != index){
                                                              audioPlayerProvider.audioHelper.player.seek(Duration.zero, index: index);
                                                              if(!audioPlayerProvider.audioHelper.player.playing){
                                                                audioPlayerProvider.audioHelper.player.play();
                                                              }
                                                            } else {
                                                              if(audioPlayerProvider.audioHelper.player.playing) {
                                                                audioPlayerProvider.audioHelper.player.pause();
                                                              } else {
                                                                audioPlayerProvider.audioHelper.player.play();
                                                              }
                                                            }
                                                          });
                                                        },
                                                        child: StreamBuilder<PlayerState>(
                                                          stream: audioPlayerProvider.audioHelper.player.playerStateStream,
                                                          builder: (context, snapshot) {
                                                            return Icon(
                                                              playList.contains(index) &&  audioPlayerProvider.audioHelper.player.playing  ? Icons.pause : Icons.play_arrow_sharp,
                                                              size: 35,
                                                              color: playList.contains(index) ? Colors.white : Colors.white70,
                                                            );
                                                          },
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
                                                              playListCurrentProvider.listSongCurrent![index].songTitle,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                            Text(
                                                              playListCurrentProvider.listSongCurrent![index].artistName,
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
                                                      setState(() {
                                                        check = listFavorite.contains(index);
                                                        if(check) {
                                                          listFavorite.remove(index);
                                                        } else {
                                                          listFavorite.add(index);
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      listFavorite.contains(index) ? Icons.favorite : Icons.favorite_border_outlined,
                                                      color: listFavorite.contains(index) ? const Color.fromRGBO(39, 183, 90, 1.0) : Colors.white,
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
                                    }
                                    return const CircularProgressIndicator();
                                  }
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
