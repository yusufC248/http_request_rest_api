import 'dart:convert';

List<Search> searchFromJson(String str) => List<Search>.from(json.decode(str).map((x) => Search.fromJson(x)));

String searchToJson(List<Search> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Search {
  Search({
    this.id,
    this.title,
    this.url,
  });

  int? id;
  String? title;
  String? url;


  factory Search.fromJson(Map<String, dynamic> json) => Search(
    id: json["id"],
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
  };
}