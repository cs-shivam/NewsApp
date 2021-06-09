import 'package:flutter/material.dart';

class TabSwitchModel with ChangeNotifier{
  int _currentTabIndex = 0 ;
  
  get currentTabIndex => _currentTabIndex;
  
  set currentTabIndex(int tabIndex){
    _currentTabIndex = tabIndex;
    notifyListeners();
  }
}