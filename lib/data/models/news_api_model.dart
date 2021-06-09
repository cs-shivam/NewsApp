import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part "news_api_model.g.dart";

class NewsAPIResponse {
  NewsAPIResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory NewsAPIResponse.fromJson(Map<String, dynamic> json) => NewsAPIResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );
}

@HiveType(typeId: 0)
class Article {
  Article({@required Source source,@required String author, 
          @required String title, @required String description, 
          @required String url, @required String urlToImage,  
          @required String publishedAt, @required String content,
          bool isAdded = false}){
    this.source = source;
    this.author = author;
    this.title= title;
    this.description = description;
    this.url = url;
    this.urlToImage = urlToImage;
    this.publishedAt = publishedAt;
    this.content = content;
    this.isAdded = isAdded;
  }
  @HiveField(0)
  Source source;
  @HiveField(1)
  String author;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  String url;
  @HiveField(5)
  String urlToImage;
  @HiveField(6)
  String publishedAt;
  @HiveField(7)
  String content;
  @HiveField(8)
  bool isAdded;
  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"],
      );


  void toggleAdded(){
    isAdded = !isAdded;
  }
}

@HiveType(typeId: 1)
class Source {
  Source({
    this.id,
    this.name,
  });
 @HiveField(0)
  String id;
 @HiveField(1)
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
      );
}