import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifecoach_app/common_widget/paltform_widget.dart';


//concreate class ---> somut sınıf
class PlatformAlertDialog extends PlatformWidget{

final String header;
final String content;
final String mainButtonText;
final String closeButtonText;

  PlatformAlertDialog({@required this.header,
    @required this.content,
    @required this.mainButtonText,
    this.closeButtonText});

  Future<bool> show(BuildContext context) async{
    return Platform.isIOS ? await showCupertinoDialog<bool>(context: context, builder: (context)=>this) :
          await showDialog<bool>(context: context, builder: (context)=>this, barrierDismissible: false);
  }



  @override
  Widget buildAndroidWidget(BuildContext context) {
      return AlertDialog(
         title: Text(header),
        content: Text(content),
        actions:
          _setDialogButton(context),

      );

  }

  @override
  Widget buildIOSWidget(BuildContext context) {

    return CupertinoAlertDialog(
      title: Text(header),
      content: Text(content),
      actions:
      _setDialogButton(context),

    );
  }

  List<Widget> _setDialogButton(BuildContext context) {//içinde widget olan bir liste döndürücek
        final allButtons = <Widget> [];
        if(Platform.isIOS){
          if(closeButtonText != null){
            allButtons.add(CupertinoDialogAction(child: Text(closeButtonText),
              onPressed: (){
                Navigator.of(context).pop(false);
              },
            ),
            );
          }
            allButtons.add(
                CupertinoDialogAction(
                  child:
                  Text(mainButtonText),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                ),
            );
        }else{
          if(closeButtonText != null){
            allButtons.add(FlatButton(child: Text(closeButtonText),
              onPressed: (){
                Navigator.of(context).pop(false);
              },
            ),
            );
          }
          allButtons.add(FlatButton(
              onPressed: (){
                Navigator.of(context).pop(true);
              },
              child: Text("Okay")));
        }

        return allButtons;

  }

}