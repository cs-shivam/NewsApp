import 'package:flutter/material.dart';
import 'package:news_app/data/provider/tab_switch_model.dart';
import 'package:news_app/screens/bookmark/bookmark_screen.dart';
import 'package:news_app/screens/news/news_screen.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages;
  PageController _pc;
  var _currentPage;
  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pages = [
      News(),
      Bookmark(),
    ];
    _pc = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    logger.v('Verbose Log');
    var tabSwitchProvider = Provider.of<TabSwitchModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 20.0,
        toolbarHeight: 52,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                 'assets/logo.png',
                  fit: BoxFit.contain,
                  height: 32,
            ),
            Text(
              " Apple ",
              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body:
      PageView(
        controller: _pc,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,  
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white30,
        elevation: 20.0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: tabSwitchProvider.currentTabIndex,
        //currentIndex: _currentPage,             
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label : 'News Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label : 'Bookmarks'
          ),
        ],
        
        onTap : (index){
          logger.i('Info Log');
          tabSwitchProvider.currentTabIndex = index;
          _pc.jumpToPage(index);
        }
      ),
    );
  }
}