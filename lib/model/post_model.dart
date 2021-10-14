import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post{
  String? link;
  Title? title;
  String? date;

  Post({
    this.link,
    this.title,
    this.date
  });


  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
        link: json["link"],
        date: json["date"],
        title: Title.fromJson(json["title"],
        )
    );
  }

  Map<String, dynamic> toJson() => {
    "link": link,
    "title": title!.toJson(),
    "date": date,
  };
}

class Title{
  String? rendered;

  Title({
    this.rendered,
  });


  factory Title.fromJson(Map<String, dynamic> json){
    return Title(
      rendered: json["rendered"],
    );
  }
  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };

}


