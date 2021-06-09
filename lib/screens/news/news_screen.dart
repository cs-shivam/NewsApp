import 'package:flutter/material.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:news_app/widgets/news_list_widget.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin<News>{
  @override
  Widget build(BuildContext context) {
     super.build(context);
      return Container(
       child : Consumer<NewsListModel>(
        builder : (context,newsArticle,child) => NewsListWidget(
          newsArticle: newsArticle.allnews,
       ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

