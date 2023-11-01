import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momanga/data/api/api_service.dart';
import 'package:momanga/data/model/manga.dart';

import '../widget/card_vertical.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<MangaList> searchResults = [];

  Future<void> performSearch(String searchTerm) async {
    try {
      final results = await ApiService().searchManga(searchTerm);
      setState(() {
        searchResults = results.mangaList!;
      });
    } catch (e) {
      // Handle error, e.g., display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Column(
            children: [
              CupertinoSearchTextField(
                autofocus: true,
                onChanged: (String value) {
                  print('The text has changed to: $value');
                },
                onSubmitted: (String value) {
                  print('Submitted text: $value');
                  performSearch(value); // Call the search function here
                },
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return CardVertical(manga: searchResults[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
