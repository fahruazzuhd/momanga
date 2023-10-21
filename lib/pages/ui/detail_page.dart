import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momanga/data/api/api_service.dart';
import 'package:momanga/pages/widget/expandable_text.dart';

import '../../data/model/detail_manga.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.data,});

  final String data;

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  // late Future<Detail> _detailManga;
  Detail? _detailManga;

  @override
  void initState() {
    super.initState();
    // _detailManga = ApiService().detailManga();
    ApiService().detailManga(widget.data).then((value) {
      setState(() {
        _detailManga = value;
      });
      // print(_detailManga);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _detailManga == null ? Center(child: CircularProgressIndicator()) :
      CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            // title: Text('Attack on Titan', textScaleFactor: 1,
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white
            //   ),),
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: false,
              // collapseMode: CollapseMode.pin,
              // title: Text(_detailManga!.title!, textScaleFactor: 1, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
              background: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.5),
                    BlendMode.darken
                ),
                child: Image.network(_detailManga!.thumb!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _detailManga!.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        _detailManga!.author!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sinopsis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      // Text(
                      //   text,
                      //   style: TextStyle(
                      //       fontSize: 13,
                      //       // color: Colors.grey
                      //   ),
                      // )
                      ExpandableText(
                        _detailManga!.synopsis!.replaceAll(RegExp(r'[\n\t]'), ''),
                        trimLines: 3,
                      )
                    ],
                  ),
                ),
                // ListView.builder(
                //   itemCount: _detailManga!.chapter!.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       leading: Icon(Icons.book), // Icon buku
                //       title: Text(_detailManga!.chapter![index].chapterTitle!), // Label "Chapter xxx"
                //       onTap: () {
                //         // Aksi yang akan diambil saat item diklik
                //         // Misalnya, navigasi ke halaman detail chapter.
                //       },
                //     );
                //   },
                // )
                ..._detailManga!.chapter!.map((e) {
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text(e.chapterTitle!),
                    onTap: () {
                      // Aksi yang akan diambil saat item diklik
                      // Misalnya, navigasi ke halaman detail chapter.
                    },
                  );
                }).toList()
              ],
            ),
          )
        ],
      ),
    );
  }

}