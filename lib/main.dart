import 'package:flutter/material.dart';
import 'package:lifecoach_app/landing_page.dart';
import 'package:lifecoach_app/locator.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> UserModel(),
      child: MaterialApp(
        title: 'Flutter Lovers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: LandingPage()),

    );
  }
}