
import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/custom_bottom_navi.dart';
import 'package:lifecoach_app/app/nutrition.dart';
import 'package:lifecoach_app/app/profile.dart';
import 'package:lifecoach_app/app/sports.dart';
import 'package:lifecoach_app/app/tab_items.dart';
import 'package:lifecoach_app/app/toDo.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'model/user_model.dart';

class  HomePage extends StatefulWidget {


  final User user;


   HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TabItem _currentTab = TabItem.Sports; //sayfada ilk açılıcak sayfayı belirledik.
  Map<TabItem, Widget> allPages() {
    return {
      TabItem.Sports : SportsPage(),
      TabItem.Nutrition : NutritionPage(),
      TabItem.ToDo : ToDoPage(),
      TabItem.Profil : ProfilePage(),
    };
  }


  @override
  Widget build(BuildContext context) {

    return Container(child: CustomBottomNavigation(createPage : allPages(), currentTab: _currentTab, onSelectedTab: (selectedTab){
      setState(() {
        _currentTab=selectedTab;
      });
    },),);





  }


}
/*

Future<bool> _logOut(BuildContext context) async{
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool result = await _userModel.signOut();
    return result;
  }
 */


