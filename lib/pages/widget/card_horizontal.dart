import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:momanga/data/model/manga.dart';

class CardHorizontal extends StatelessWidget {
  final MangaList manga;

  const CardHorizontal({required this.manga});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              manga.thumb!,
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            manga.title!,
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Author",
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey
            ),
          )
        ],
      ),
    );
  }
}
