import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/data/models/news_api_model.dart';
import 'package:news_app/services/fetch_news.dart';

class NewsListModel extends ChangeNotifier{
  final String _key = 'artKey';
  List<Article> newsArticle = [];
  Box<dynamic> _articles;
  int pageNo = 1;
  // @override

  NewsListModel(Box<dynamic> articles){
   _articles = articles;
    // print(_articles);
    var boxdata = _articles.get(_key , defaultValue: []);
    //print(boxdata);
    List<Article> tempList =  boxdata.cast<Article>();
    //print("length of string is : ");
    //print(tempList.length);
    pageNo = tempList.length ~/ 5 + 1;
    makeArticleList(tempList);

  }

  void makeArticleList( List<Article> artList ){
    artList.forEach((item) => newsArticle.add(item));
  }

  Future<void> getNextPage() async{
      var futuredata = await NewsApiServices().fetchNewsArticle(pageNo);
     // print(pageNo);
      if(futuredata != null) futuredata.forEach((element) => newsArticle.add(element));
      else{
          print("Error");
      }
      _articles.put(_key, newsArticle);
      notifyListeners();
      pageNo++;
    //print(newsArticle.length);
   // notifyListeners();
  }
  
  UnmodifiableListView<Article> get allnews => UnmodifiableListView(newsArticle);
  UnmodifiableListView<Article> get bookmarks => UnmodifiableListView(newsArticle.where((article) => article.isAdded));
  
  void toggleNews(Article article){
    final articleIndex = newsArticle.indexOf(article);
    newsArticle[articleIndex].toggleAdded();
    _articles.put(_key, newsArticle);
    notifyListeners();
  }

  void clearAllBookmarks(){
    
    for(int i = 0;i<newsArticle.length;i++){
      if(newsArticle[i].isAdded){
        newsArticle[i].toggleAdded();
      }
    }
    _articles.put(_key, newsArticle);
    notifyListeners();
  }
}