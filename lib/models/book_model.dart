import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  Book({
    this.id,
    this.title,
    this.author,
  });

  String id;
  String title;
  String author;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
      };
}
