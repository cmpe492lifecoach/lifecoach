import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/reusable_card.dart';

import 'package:lifecoach_app/app/sports_page_extra/bodybuilding_page.dart';
import 'package:lifecoach_app/app/sports_page_extra/bottom_button.dart';

class SportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sports"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
         Expanded(
           child: ReusableCard(
            
             onPress: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context)=> BodyBuildingPage())
               );

             },
             colour: Colors.deepPurpleAccent,
             

             cardChild: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5SKtBifX8PHfjVGL7q7mNutqIOHTPlqlWtw&usqp=CAU'),
                 SizedBox(height: 10,),
                 Text(
                   'BODYBUILDING',
                   style: TextStyle(color: Colors.white,),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.baseline,
                   textBaseline: TextBaseline.alphabetic,
                   children: <Widget>[


                   ],
                 ),

               ],
             ),
           ),
         ),
         Expanded(
           child: ReusableCard(
             onPress: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context)=> BodyBuildingPage())
               );

             },
             colour: Colors.deepPurpleAccent,
             cardChild: Column(
               mainAxisAlignment: MainAxisAlignment.center,

               children: <Widget>[
                 Image.network('https://p.kindpng.com/picc/s/616-6167538_run-icon-circle-hd-png-download.png'),
                 SizedBox(height: 10,),
                 Text(
                   'RUNNING',
                   style: TextStyle(color: Colors.white),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.baseline,
                   textBaseline: TextBaseline.alphabetic,
                   children: <Widget>[


                   ],
                 ),

               ],
             ),
           ),
         ),
         BottomButton(
           buttonTitle: 'CALCULATE',
           onTap: () {



           },
         ),

        ],




      ),

    );
  }
}


