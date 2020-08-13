import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class ChangeLanguage extends StatefulWidget{
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String radioItem="1";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            "change_language",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body(context)
    );
  }


  Widget body(BuildContext context) {

    return Column(
      children: <Widget>[
        RadioListTile(
          title: MyText("arabic",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: "Cairo"),),
          groupValue:radioItem ,
          value: '1',
          onChanged: (val) {
            setState(() {
             radioItem = val;
            });
          },
        ),

        RadioListTile(
          title: MyText('english',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: "Cairo")),
          groupValue: radioItem,
          value: '2',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
      ],
    );
  }
}