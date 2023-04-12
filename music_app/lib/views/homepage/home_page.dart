import 'package:flutter/material.dart';
import 'package:music_app/provider/home_page_provider.dart';
import 'package:music_app/views/homepage/home_page_navigator.dart';
import 'package:provider/provider.dart';

class Single {
  final String name;
  final String image;

  Single({required this.name,required this.image});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Consumer<HomePageProvider>(
      builder: (context, homePageProvider, child) => Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              IndexedStack(
                index: homePageProvider.navigatorBottomIndex,
                children: homePageProvider.screens,
              ),
              const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: NavigatorBottom()
              )
            ],
          ),
        ),
      ),
    );
  }

}