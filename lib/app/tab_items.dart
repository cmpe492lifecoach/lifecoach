import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {Sports,Nutrition,ToDo,Profil} // 0,1,2,3

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.Sports : TabItemData("Sports", Icons.sports),
    TabItem.Nutrition : TabItemData("Nutrition", Icons.set_meal),
    TabItem.ToDo : TabItemData("ToDo", Icons.note_add),
    TabItem.Profil : TabItemData("Profile", Icons.supervised_user_circle),
};

}