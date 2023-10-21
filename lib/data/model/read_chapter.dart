class ReadChapter {
  String? chapterEndpoint;
  String? chapterName;
  String? title;
  int? chapterPages;
  List<ChapterImage>? chapterImage;

  ReadChapter(
      {this.chapterEndpoint,
        this.chapterName,
        this.title,
        this.chapterPages,
        this.chapterImage});

  ReadChapter.fromJson(Map<String, dynamic> json) {
    chapterEndpoint = json['chapter_endpoint'];
    chapterName = json['chapter_name'];
    title = json['title'];
    chapterPages = json['chapter_pages'];
    if (json['chapter_image'] != null) {
      chapterImage = <ChapterImage>[];
      json['chapter_image'].forEach((v) {
        chapterImage!.add(new ChapterImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_endpoint'] = this.chapterEndpoint;
    data['chapter_name'] = this.chapterName;
    data['title'] = this.title;
    data['chapter_pages'] = this.chapterPages;
    if (this.chapterImage != null) {
      data['chapter_image'] =
          this.chapterImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterImage {
  String? chapterImageLink;
  int? imageNumber;

  ChapterImage({this.chapterImageLink, this.imageNumber});

  ChapterImage.fromJson(Map<String, dynamic> json) {
    chapterImageLink = json['chapter_image_link'];
    imageNumber = json['image_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_image_link'] = this.chapterImageLink;
    data['image_number'] = this.imageNumber;
    return data;
  }
}
