class Recomended {
  bool? status;
  String? message;
  List<MangaList>? mangaList;

  Recomended({this.status, this.message, this.mangaList});

  Recomended.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['manga_list'] != null) {
      mangaList = <MangaList>[];
      json['manga_list'].forEach((v) {
        mangaList!.add(new MangaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.mangaList != null) {
      data['manga_list'] = this.mangaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MangaList {
  String? title;
  String? thumb;
  String? endpoint;

  MangaList({this.title, this.thumb, this.endpoint});

  MangaList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    endpoint = json['endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    data['endpoint'] = this.endpoint;
    return data;
  }
}
