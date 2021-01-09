import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

class About extends StatefulWidget{
  String test="";
  About(this.test);
  @override
  _AboutState createState() => _AboutState(test);
}


class _AboutState extends State<About> {
  String test="";
  _AboutState(this.test);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            "about",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body(context)
    );
  }

  Widget body(BuildContext context) {
    return ListView(
      children: [
        aboutText()

      ],
    );

  }

  Widget aboutText() {
    StorageUtil.getInstance().then((storage) {
      test = StorageUtil.getString(Constant.ABOUT);
    });
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Text(test,
        style: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.w500,
            fontSize: 16, color: Colors.black),),
    );

  }
}