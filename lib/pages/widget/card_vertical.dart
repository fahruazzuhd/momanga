import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:momanga/data/model/manga.dart';
import 'package:momanga/pages/ui/detail_page.dart';

class CardVertical extends StatelessWidget {
  final MangaList manga;

  const CardVertical({required this.manga});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(data: manga.endpoint!),
          ),
        );
      },
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png', // Gambar placeholder kustom
                  image: manga.thumb!,
                  fit: BoxFit.cover,
                  width: 120,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/images/placeholder.png',
                      width: 120,
                    ); // Gambar error kustom
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Text(
                      manga.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        "Author",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  Transform(
                    transform: new Matrix4.identity()..scale(0.75),
                    child: Chip(
                      shape: StadiumBorder(),
                      side: BorderSide(
                          width: 1,
                          color: Colors.deepOrange
                      ),
                      backgroundColor: HexColor('#FFEBF0'),
                      label: Text(
                        'Chapter: 000',
                        style: TextStyle(
                            color: Colors.deepOrange
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
