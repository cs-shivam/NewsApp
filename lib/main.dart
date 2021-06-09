import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/data/models/news_api_model.dart';
import 'package:news_app/data/provider/news_api_list_model.dart';
import 'package:news_app/data/provider/tab_switch_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDir = await getApplicationDocumentsDirectory();
  Hive.init(documentDir.path);
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(SourceAdapter());
  final Box<dynamic> art = await Hive.openBox("newsArticles");

  runApp(NewsApp(articles :art));
}

class NewsApp extends StatelessWidget {

  final Box<dynamic> articles;
  NewsApp({this.articles});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabSwitchModel()),
        ChangeNotifierProvider(create: (context) => NewsListModel(articles)),
      ],
      child: MaterialApp(
        title: 'Apple News',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: HomeScreen(),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: new Scaffold(
//         appBar: new AppBar(
//           bottom: new TabBar(
//             tabs: [
//               new Tab(icon: new Icon(Icons.directions_car)),
//               new Tab(icon: new Icon(Icons.directions_transit)),
//               new Tab(icon: new Icon(Icons.directions_bike)),
//               new Tab(
//                 icon: new Icon(Icons.airplanemode_active),
//               )
//             ],
//           ),
//         ),
//         body: new TabBarView(children: [
//           new OnePage(color: Colors.black,),
//           new OnePage(color: Colors.green,),
//           new OnePage(color: Colors.red,),
//           new OnePage(color: Colors.blue,),
//         ]),
//       ),
//     );
//   }
// }

// class OnePage extends StatefulWidget {
//   final Color color;

//   const OnePage({Key key, this.color}) : super(key: key);

//   @override
//   _OnePageState createState() => new _OnePageState();
// }

// class _OnePageState extends State<OnePage> with AutomaticKeepAliveClientMixin<OnePage> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return new SizedBox.expand(
//       child: new ListView.builder(
//         itemCount: 100,
//         itemBuilder: (context, index) {
//           return new Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: new Text(
//               '$index',
//               style: new TextStyle(color: widget.color),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
