import 'package:flutter/material.dart';
import 'package:music_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, homePageProvider, child) => Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                height: 100,
                margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(37, 37, 37, 1.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.search_outlined, color: Colors.grey,size: 30,),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17
                    ),
                  ),
                )
            ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      const Text(
                        "Recent Search",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: homePageProvider.listDataSong.length,
                          itemBuilder: (context, index) => Container(
                            height: 100,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(70),
                                        child: Image.network(
                                          homePageProvider.listDataSong[index].image,
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 30,left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(
                                            homePageProvider.listDataSong[index].nameSong,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          Text(
                                            homePageProvider.listDataSong[index].single,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white70,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
