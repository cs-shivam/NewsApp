import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_api_model.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:provider/provider.dart';
import 'news_tile.dart';

class BookmarkListWidget extends StatelessWidget {
  
  final List<Article> newsArticle;
  BookmarkListWidget({@required this.newsArticle});
  
  @override
  Widget build(BuildContext context) {
    if(newsArticle.length == 0){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/bookmarks.png',
                    height: 200,
                    //width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "!! No Bookmarks !!",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
          ],
        ),
      );
    }
    else{
      return ListView.builder(
      itemCount: newsArticle.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if(index == newsArticle.length){
         return  Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey, // background
                  onPrimary: Colors.black, // foreground
                ),
                onPressed: () {
                  Provider.of<NewsListModel>(context , listen : false).clearAllBookmarks(); 
                  //newsArticle.clearBookmarks();
                },
                child: Text('Click to clear All!'),
              )
            ),
          ],
         );
        }
        else return NewsTile(article: newsArticle[index],);
      },
    );
    }
  }
}

             