import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_api_model.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:provider/provider.dart';

import 'news_tile.dart';

class NewsListWidget extends StatelessWidget  {
  final List<Article> newsArticle;
  NewsListWidget({@required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
  Widget _buildList() {
    return ListView.builder(
      itemCount: newsArticle.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if(index == newsArticle.length){
          Provider.of<NewsListModel>(context , listen : false).getNextPage();
          return _buildProgressIndicator();
        }
        else return NewsTile(article: newsArticle[index],);
      },
    );
  }

 Widget _buildProgressIndicator() {
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: 1.0,
            child: new CircularProgressIndicator(
              semanticsValue: "Loading More data",
              backgroundColor:Colors.red,
            ),
          ),
        ),
      );
  }


}