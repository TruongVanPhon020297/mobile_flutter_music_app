import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/provider/audio_player_provider.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:music_app/provider/home_page_provider.dart';
import 'package:music_app/provider/play_list_current_provider.dart';
import 'package:music_app/provider/play_list_page_provider.dart';
import 'package:music_app/provider/play_music_page_provider.dart';
import 'package:music_app/provider/user_page_provider.dart';
import 'package:music_app/views/homepage/home_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayListPageProvider(),
        ),ChangeNotifierProvider(
          create: (context) => PlayListCurrentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioPlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayMusicPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DownloadProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserPageProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: "Home Page"),
      ),
    );
  }
}

