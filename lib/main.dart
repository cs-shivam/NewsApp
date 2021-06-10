import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:news_app/data/models/news_api_model.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:news_app/data/provider/tab_switch_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home/home_screen.dart';


var logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDir = await getApplicationDocumentsDirectory();
  Hive.init(documentDir.path);
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(SourceAdapter());
  final Box<dynamic> art = await Hive.openBox("newsArticles");
  
  runApp(NewsApp(articles : art));
}

class NewsApp extends StatelessWidget {

  final Box<dynamic> articles;
  NewsApp({this.articles});

  
  
  @override
  Widget build(BuildContext context) {
    logger.d('logger is working');
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => TabSwitchModel()),
        ChangeNotifierProvider(create: (context) => NewsListModel(articles)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apple News',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: HomeScreen(),
      ),
    );
  }
}