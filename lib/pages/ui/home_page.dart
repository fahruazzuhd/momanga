import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:momanga/data/model/manga.dart';
import 'package:momanga/pages/widget/card_horizontal.dart';
import 'package:momanga/pages/widget/card_vertical.dart';

import '../../data/api/api_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<Recomended> _mangaList;
  late Future<Recomended> _popularList;

  @override
  void initState() {
    super.initState();
    _mangaList = ApiService().topHeadlines();
    _popularList = ApiService().popularManga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                            'assets/images/avatar.png',
                          width: 70,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Malam,',
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                            Text(
                              'Fahru',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    CupertinoSearchTextField(
                      onChanged: (String value) {
                        print('The text has changed to: $value');
                      },
                      onSubmitted: (String value) {
                        print('Submitted text: $value');
                      },
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 40,),
              Container(
                height: MediaQuery.of(context).size.height * (4/5) - 50,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Trending Manga'),
                          Icon(Icons.menu),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 230,
                        child: FutureBuilder(
                          future: _popularList,
                          builder: (context,AsyncSnapshot<Recomended> snapshot) {
                            var state = snapshot.connectionState;
                            if (state != ConnectionState.done) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              if(snapshot.hasData){
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.mangaList!.length,
                                  itemBuilder: (context, index) {
                                    var popularManga = snapshot.data?.mangaList?[index];
                                    return CardHorizontal(manga: popularManga!);
                                  },
                                );
                              } else if (snapshot.hasError){
                                return Center(
                                  child: Material(
                                    child: Text(snapshot.error.toString()),
                                  ),
                                );
                              } else {
                                return const Material(child: Text('ada kesalahan'));
                              }
                            }
                          },
                        )
                      ),
                      Chip(
                        label: Text('Recomended'),
                        side: BorderSide(
                          width: 0.1,
                          color: Colors.white
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        backgroundColor: HexColor('#54BAB9'),
                        shape: StadiumBorder(),
                      ),
                      FutureBuilder(
                        future: _mangaList,
                        builder: (BuildContext context, AsyncSnapshot<Recomended> snapshot) {
                          var state = snapshot.connectionState;
                          if (state != ConnectionState.done) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasData){
                              return Column(
                                children: snapshot.data?.mangaList!.map((e) => CardVertical(manga: e)).toList() as List<Widget>,
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Material(
                                  child: Text(snapshot.error.toString()),
                                ),
                              );
                            } else {
                              return const Material(child: Text('Ada kesalahan'));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
