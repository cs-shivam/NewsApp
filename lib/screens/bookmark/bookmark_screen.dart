import 'package:flutter/material.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:news_app/widgets/bookmark_list_widget.dart';
import 'package:provider/provider.dart';


class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> with AutomaticKeepAliveClientMixin<Bookmark>{
 
  @override
  bool get wantKeepAlive => true;


   @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child : Consumer<NewsListModel>(
        builder : (context,newsArticle,child) => BookmarkListWidget(
          newsArticle: newsArticle.bookmarks,
        ),
      ),
    );
  }

}