import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/QuestionAndAnswersScreen.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class QuestionsSections extends StatelessWidget{
  String appBarHeader="";
  QuestionsSections(this.appBarHeader);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            '$appBarHeader',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                viewCard(context, "definitions_laws"),
                viewCard(context, "mention_number"),
                viewCard(context, "explain"),
                viewCard(context, "clear_up"),
                viewCard(context, "interpret"),
                viewCard(context, "reason"),
              ],
            ),
          ],
        ));
  }

  Widget viewCard(BuildContext context,String title){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>QAndAnswers(title)));
      },
      child: Card(
        elevation: 4,
        child: ListTile(
          title: MyText(
            title,
            style: TextStyle(
                fontFamily: "Cairo",
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 14,
          ),
        ),
      ),
    );

  }

}