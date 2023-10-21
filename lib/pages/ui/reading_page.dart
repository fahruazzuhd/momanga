import 'package:flutter/material.dart';
import 'package:momanga/data/model/read_chapter.dart';

import '../../data/api/api_service.dart';

class ReadManga extends StatefulWidget {
  const ReadManga({super.key});

  @override
  State<ReadManga> createState() => _ReadMangaState();
}

class _ReadMangaState extends State<ReadManga> {

  late Future<ReadChapter> _chapter;

  @override
  void initState() {
    super.initState();
    _chapter = ApiService().readChapter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Judul baca manga'),
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
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fill,
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
