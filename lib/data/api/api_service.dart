import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:momanga/data/model/detail_manga.dart';
import 'package:momanga/data/model/manga.dart';
import 'package:momanga/data/model/read_chapter.dart';


class ApiService {
  static const String _baseUrl = 'http://172.20.10.4:3000/api';

  Future<Recomended> topHeadlines() async {
    final response = await http.get(Uri.parse("${_baseUrl}/recommended/"));
    if (response.statusCode == 200) {
      return Recomended.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
  Future<Recomended> popularManga() async {
    final response = await http.get(Uri.parse("${_baseUrl}/manga/popular/1"));
    if (response.statusCode == 200) {
      return Recomended.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<Detail> detailManga(String endpoint) async {
    final response = await http.get(Uri.parse('${_baseUrl}/manga/detail/${endpoint}'));
    print(response.body);
    print(Detail.fromJson(json.decode(response.body)).thumb);
    if (response.statusCode == 200) {
      return Detail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<ReadChapter> readChapter(String endpoint) async {
    final response = await http.get(Uri.parse(
        '${_baseUrl}/chapter/${endpoint}'
    ));
    print(response.body);
    // print(ReadChapter.fromJson(json.decode(response.body)).thumb);
    if (response.statusCode == 200) {
      return ReadChapter.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<Recomended> searchManga(String endpoint) async {
    final response = await http.get(Uri.parse(
        '${_baseUrl}/search/${endpoint}'
    ));
    print(response.body);
    // print(ReadChapter.fromJson(json.decode(response.body)).thumb);
    if (response.statusCode == 200) {
      return Recomended.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
