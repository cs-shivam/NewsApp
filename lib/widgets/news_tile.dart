import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_api_model.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:news_app/widgets/webview_widget.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class NewsTile extends StatelessWidget {
  final Article article;
  NewsTile({@required this.article}); 
  
  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.only(bottom: 15 , left: 8, right: 8),
      elevation: 20,
      shadowColor: Colors.blueGrey,
      color : Colors.white70,
      child: InkWell(
        
        onTap: ()  {
          _handleURLButtonPress(context,article.url);
         // logger.v("Verbose log");
         // logger.d("Debug log");
          logger.i("Info log");
         // logger.w("Warning log");
         // logger.e("Error log");
         // logger.wtf("What a terrible failure log");
        },
        child : Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child : CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // child: Image.network(
                  //   article.urlToImage,
                  //   height: 200,
                  //   width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.cover,
                  // )
                ),
                SizedBox(height: 12,),
                Text(
                  article.title,
                  maxLines: 2,
                  style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4,),
                Text(
                  article.description,
                  maxLines: 4,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(height: 2,),
                ListTile(
                  title: Text(
                    (article.author != null && article.author[0] != 'h'? article.author : "Oops!! No Author Name."),// + " "+ articles[index]['publishedAt'] ,
                    style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w600),
                  ),
                  
                  trailing: new Column(
                    children: <Widget>[
                      new Container(
                        child: new IconButton(        
                          icon: new Icon(
                            article.isAdded ? Icons.bookmark : Icons.bookmark_border,
                            color : article.isAdded ? Colors.red : null,
                          ),
                          onPressed: () { 
                            logger.i('Info Log');
                            Provider.of<NewsListModel>(context , listen : false).toggleNews(article);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                  
              ],
            ),
          ),
        )
      ),
    );
  }


  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}

/*
CachedNetworkImage(
        imageUrl: "http://via.placeholder.com/350x150",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
*/