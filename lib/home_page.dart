
import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/agenda_page/screens/calendar_page.dart';
import 'package:lifecoach_app/app/custom_bottom_navi.dart';
import 'package:lifecoach_app/app/nutrition.dart';
import 'package:lifecoach_app/app/profile.dart';
import 'package:lifecoach_app/app/sports.dart';
import 'package:lifecoach_app/app/tab_items.dart';
import 'app/agenda_page/toDo.dart';
import 'model/user.dart';

class  HomePage extends StatefulWidget {


  final User user;


   HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TabItem _currentTab = TabItem.Sports; //sayfada ilk açılıcak sayfayı belirledik.

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Sports : GlobalKey<NavigatorState>(),
    TabItem.Nutrition : GlobalKey<NavigatorState>(),
    TabItem.ToDo : GlobalKey<NavigatorState>(),
    TabItem.Profil : GlobalKey<NavigatorState>(),
  };


  Map<TabItem, Widget> allPages() {
    return {
      TabItem.Sports : SportsPage(),
      TabItem.Nutrition : NutritionPage(),
      TabItem.ToDo : CalendarPage(),
      TabItem.Profil : ProfilePage(),
    };
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CustomBottomNavigation(
        createPage : allPages(),
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectedTab: (selectedTab){
          //diğer sayfaları açıldığında en başa dönme işlemi
          if(selectedTab == _currentTab){
            navigatorKeys[selectedTab].currentState.popUntil((route) => route.isFirst);
          }else{
            setState(() {
              _currentTab=selectedTab;
            });
          }



    },),);





  }


}



