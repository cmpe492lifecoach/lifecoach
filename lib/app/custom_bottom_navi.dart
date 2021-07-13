import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/tab_items.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key key, @required this.currentTab, @required this.onSelectedTab, @required this.createPage}) : super(key: key);



  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> createPage;





  @override
  Widget build(BuildContext context) {
    //tabBar ekranda görünürlüğü ilgili kısım. tabBuilder hangi verilerin görücülüceği kısımdır.
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(
      items: [
        _createNewItem(TabItem.Sports),
        _createNewItem(TabItem.Nutrition),
        _createNewItem(TabItem.ToDo),
        _createNewItem(TabItem.Profil),

      ],
      onTap: (index)=>onSelectedTab(TabItem.values[index]),
    ),
    tabBuilder: (context,index) {
      final showItem = TabItem.values[index];
      return CupertinoTabView(
        builder: (context) {
              return createPage[showItem];
        });

    },
    );
  }



  BottomNavigationBarItem _createNewItem(TabItem tabItem) {
    final creatingnewTabs = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(creatingnewTabs.icon),
      title: Text(creatingnewTabs.title),
    );
  }

}
