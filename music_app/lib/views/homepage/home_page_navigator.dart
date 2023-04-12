import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/provider/home_page_provider.dart';
import 'package:music_app/views/justautio/control_button_home_page.dart';
import 'package:provider/provider.dart';

import '../../provider/audio_player_provider.dart';
import '../../provider/play_list_current_provider.dart';
import '../../provider/play_list_page_provider.dart';
import '../play_music.dart';

class NavigatorBottom extends StatelessWidget {
  const NavigatorBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer4<HomePageProvider,PlayListPageProvider,PlayListCurrentProvider,AudioPlayerProvider>(
      builder: (context, homePageProvider, playListPageProvider, playListCurrentProvider, audioPlayerProvider, child) => SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10
            ),
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child: audioPlayerProvider.listSongPlay!.isEmpty ?
                    Row(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PlayMusic(title: "Play Music"),
                                    )
                                ),
                                child: Hero(
                                  tag: 'ssss',
                                  child: Image.network(
                                    'https://bazaarvietnam.vn/wp-content/uploads/2021/10/Adele-easy-on-me-8668-scaled-e1634283165498.jpg',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Easy On Me",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Adele",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: (){

                                  },
                                  child:const Icon(
                                    Icons.favorite,
                                    color: Color.fromRGBO(39, 184, 91, 1.0),
                                    size: 30,
                                  )
                              ),
                              GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    margin: const EdgeInsets.only(left: 30),
                                    decoration: BoxDecoration(
                                        border:  const Border.fromBorderSide(
                                            BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(39, 184, 91, 1.0)
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child:const Icon(
                                      Icons.pause,
                                      color: Colors.white70,
                                      size: 30,
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ) :
                    StreamBuilder<SequenceState?>(
                      stream: audioPlayerProvider.audioHelper.player?.sequenceStateStream,
                      builder: (context,AsyncSnapshot<SequenceState?> snapshot) {

                        if(snapshot.hasData) {
                          return Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const PlayMusic(title: "Play Music"),
                                            )
                                        ),
                                        child: Hero(
                                          tag: 'ssss',
                                          child: Image.network(
                                            audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].pictureSmall,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].songTitle,
                                              style: const TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(
                                              audioPlayerProvider.listSongPlay![snapshot.data!.currentIndex].artistName,
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ControlButtonHomePage(audioPlayerProvider.audioHelper.player!)
                                ],
                              )
                            ],
                          );
                        }

                        return const CircularProgressIndicator();

                      },
                    )
                    ,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          homePageProvider.setNavigatorBottomIndex(0);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 30,
                              height: 3,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: homePageProvider.navigatorBottomIndex == 0 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey.withOpacity(0),
                              ),
                            ),
                            Icon(
                              Icons.warehouse_outlined,
                              color: homePageProvider.navigatorBottomIndex == 0 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          homePageProvider.setNavigatorBottomIndex(1);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 30,
                              height: 3,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: homePageProvider.navigatorBottomIndex == 1 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey.withOpacity(0),
                              ),
                            ),
                            Icon(
                                FontAwesomeIcons.search,
                                color: homePageProvider.navigatorBottomIndex == 1 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          homePageProvider.setNavigatorBottomIndex(2);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 30,
                              height: 3,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: homePageProvider.navigatorBottomIndex == 2 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey.withOpacity(0),
                              ),
                            ),
                            Icon(
                                Icons.stacked_bar_chart,
                                color: homePageProvider.navigatorBottomIndex == 2 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          homePageProvider.setNavigatorBottomIndex(3);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 30,
                              height: 3,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: homePageProvider.navigatorBottomIndex == 3 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey.withOpacity(0),
                              ),
                            ),
                            Icon(
                                Icons.perm_identity_rounded,
                                color: homePageProvider.navigatorBottomIndex == 3 ? const Color.fromRGBO(39, 184, 91, 1.0) : Colors.grey
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
