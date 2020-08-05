import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/UnitQuestionDetailsScreen.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class QAndAnswres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            'units',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 40,
              decoration: BoxDecoration(color: Color(0x11707070)),
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: MyText("first_term",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey)),
              ),
            ),
            Column(
              children: <Widget>[
                viewCard(context, "first_unit"),
                viewCard(context, "second_unit"),
                viewCard(context, "third_unit"),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 40,
              decoration: BoxDecoration(color: Color(0x11707070)),
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: MyText("second_term",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey)),
              ),
            ),
            Column(
              children: <Widget>[
                viewCard(context, "fourth_unit"),
               viewCard(context, "fifth_unit"),
                viewCard(context, "sixth_unit"),
              ],
            ),
          ],
        ));
  }

  Widget viewCard(BuildContext context,String title){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>UnitQuestions(title)));
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
