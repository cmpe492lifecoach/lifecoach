import 'package:flutter/material.dart';

class SocialLogInButton extends StatelessWidget {

  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double height;

  final VoidCallback onPressed;

  const SocialLogInButton({Key key, this.buttonText
    , this.buttonColor : Colors.purple,
    this.textColor : Colors.white,
    this.radius : 16,
    this.height : 40,

    this.onPressed}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        height: height,
        child: RaisedButton(onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : <Widget>[

              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),

              ),
              Opacity(opacity: 0,)

            ],
          ),
          color: buttonColor,
        ),
      ),
    );
  }
}
