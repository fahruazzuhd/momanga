import 'package:flutter/material.dart';
import 'package:momanga/data/model/read_chapter.dart';

import '../../data/api/api_service.dart';

class ReadManga extends StatefulWidget {
  const ReadManga({super.key, required this.data});
  final String data;

  @override
  State<ReadManga> createState() => _ReadMangaState();
}

class _ReadMangaState extends State<ReadManga> {

  late Future<ReadChapter> _chapter;
  String mangaTitle = "";

  @override
  void initState() {
    super.initState();
    _chapter = ApiService().readChapter(widget.data);

    _chapter.then((chapter) {
      setState(() {
        mangaTitle = chapter.title!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("ini data ${widget.data}");
    return Scaffold(
      appBar: AppBar(
        title: Text(mangaTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _chapter,
              builder: (context,AsyncSnapshot<ReadChapter> snapshot) {
                var state = snapshot.connectionState;
                if (state != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.chapterImage!.length,
                      itemBuilder: (context, index) {
                        var mangaChapter = snapshot.data?.chapterImage?[index];
                        return Image.network(
                          mangaChapter!.chapterImageLink!,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        );
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
            ),
          )
        ],
      ),
    );
  }
}
