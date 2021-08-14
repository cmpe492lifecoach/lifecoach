import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/runningPage.dart';

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
         Text("Exercise", style: TextStyle(
           color: Colors.lightGreen,
           fontWeight: FontWeight.bold,
           fontSize: 50,

         ),
         textAlign: TextAlign.center,),
         Expanded(
           child: Card(

             child: new InkWell(
               onTap: () {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> ExercisePage())
                 );
               },

               child: Container(
                 decoration: new BoxDecoration(
                   color: Colors.greenAccent,
                   image: new DecorationImage(image: new AssetImage("Images/exercise.jpeg"),
                   fit: BoxFit.fill,
                   ),


                 ),

                 width: 100.0,
                 height: 100.0,
               ),
             ),
           ),
         ),
         Text("Yoga", style: TextStyle(
           color: Colors.lightGreen,
           fontWeight: FontWeight.bold,
           fontSize: 50,

         ),
           textAlign: TextAlign.center,),
         Expanded(
           child: Card(

             child: new InkWell(
               onTap: () {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> YogaPage())
                 );
               },

               child: Container(
                 decoration: new BoxDecoration(
                   color: Colors.greenAccent,
                   image: new DecorationImage(image: new AssetImage("Images/yogaImage.jpeg"),
                     fit: BoxFit.fill,
                   ),


                 ),

                 width: 100.0,
                 height: 100.0,
               ),
             ),
           ),
         ),
         BottomButton(
           buttonTitle: '',

           onTap: () {



           },
         ),

        ],




      ),

    );
  }
}


