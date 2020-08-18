import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';


class Adaptiveflatbutton extends StatelessWidget {
  final String text;
  final Function handler;

  Adaptiveflatbutton(this.text, this.handler);


  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
                ? 
                CupertinoButton(
                      child: Text(text,
                     style: TextStyle(fontWeight: FontWeight.bold,
                     ),
                      ),
                   onPressed: ()
                {
                  handler();
                },   
                )
                :
                FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(text,
                     style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: ()
                {
                  handler();
                },
                );
  }
}