import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer( {this.height, this.width, this.child, this.padding});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding!=null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [LightColors.grad1, LightColors.grad2]),
         ),
      height: height,
      width: width,
      child: child,
    );
  }
}
