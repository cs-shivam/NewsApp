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

  //?constructor is used to upadte the news article list when restarting the application.Getting the data into list form hive box.
  NewsListModel(Box<dynamic> articles){
   _articles = articles;
    // print(_articles); 
    var boxdata = _articles.get(_key , defaultValue: []);
    //print(boxdata);
    List<Article> tempList =  boxdata.cast<Article>();
    //* used cast method to cast the dynamic list into article list and also used dynamic for hive box.
    //! didn't know how it worked but it worked.
    //print("length of string is : ");
    //print(tempList.length);
    pageNo = tempList.length ~/ 5 + 1;
    //! using maths to get rid of math error.There must be a better way.
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
  
  //* method used to revert the value of isAdded variable.
  void toggleNews(Article article){
    final articleIndex = newsArticle.indexOf(article);
    newsArticle[articleIndex].toggleAdded();
    _articles.put(_key, newsArticle);
    notifyListeners();
  }

  //* method used to clear all bookmarks
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