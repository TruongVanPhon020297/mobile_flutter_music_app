import 'package:flutter/material.dart';

class AlbumTopChartPageDetail extends StatefulWidget {
  const AlbumTopChartPageDetail({Key? key}) : super(key: key);

  @override
  State<AlbumTopChartPageDetail> createState() => _AlbumTopChartPageDetailState();
}

class _AlbumTopChartPageDetailState extends State<AlbumTopChartPageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 27, 31, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            height: 100,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.navigate_before,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30,right: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://e-cdns-images.dzcdn.net/images/artist/f7c043cc2f4be27cbfca9983573d7da3/120x120-000000-80-0-0.jpg",
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "ALBUM - 10 SONG",
                        style: TextStyle(
                            fontFamily: "Lon",
                            fontSize: 15,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        "Formal Chicken",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            margin: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color.fromRGBO(38, 41, 42, 1.0),
            ),
            child: const Text(
              "PLAY ALL",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
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
                            decoration:const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://e-cdns-images.dzcdn.net/images/artist/f7c043cc2f4be27cbfca9983573d7da3/120x120-000000-80-0-0.jpg"
                                    )
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10))
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
                                children: const [
                                  Text(
                                    "Bài Hát",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "Ca Sỹ",
                                    style: TextStyle(
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

                            },
                            child: const Icon(
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
            ),
          )
        ],
      ),

    );
  }
}