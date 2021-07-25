import 'package:flutter/material.dart';

class BuildMyForm extends StatelessWidget {
  final TextEditingController txtController;
  final String str;


  BuildMyForm({this.txtController, this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
          autofocus: false,
          controller: txtController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some title';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: str,
              labelStyle: TextStyle(color: Colors.black45),
              focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
        ));
  }




}