class Detail {
  String? title;
  String? type;
  String? author;
  String? status;
  String? mangaEndpoint;
  String? thumb;
  List<GenreList>? genreList;
  String? synopsis;
  List<Chapter>? chapter;

  Detail(
      {this.title,
        this.type,
        this.author,
        this.status,
        this.mangaEndpoint,
        this.thumb,
        this.genreList,
        this.synopsis,
        this.chapter});

  Detail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    author = json['author'];
    status = json['status'];
    mangaEndpoint = json['manga_endpoint'];
    thumb = json['thumb'];
    if (json['genre_list'] != null) {
      genreList = <GenreList>[];
      json['genre_list'].forEach((v) {
        genreList!.add(new GenreList.fromJson(v));
      });
    }
    synopsis = json['synopsis'];
    if (json['chapter'] != null) {
      chapter = <Chapter>[];
      json['chapter'].forEach((v) {
        chapter!.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['author'] = this.author;
    data['status'] = this.status;
    data['manga_endpoint'] = this.mangaEndpoint;
    data['thumb'] = this.thumb;
    if (this.genreList != null) {
      data['genre_list'] = this.genreList!.map((v) => v.toJson()).toList();
    }
    data['synopsis'] = this.synopsis;
    if (this.chapter != null) {
      data['chapter'] = this.chapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GenreList {
  String? genreName;

  GenreList({this.genreName});

  GenreList.fromJson(Map<String, dynamic> json) {
    genreName = json['genre_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_name'] = this.genreName;
    return data;
  }
}

class Chapter {
  String? chapterTitle;
  String? chapterEndpoint;

  Chapter({this.chapterTitle, this.chapterEndpoint});

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterTitle = json['chapter_title'];
    chapterEndpoint = json['chapter_endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_title'] = this.chapterTitle;
    data['chapter_endpoint'] = this.chapterEndpoint;
    return data;
  }
}
