import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/Units.dart';
import 'package:tawjihi/Screens/Course/OptionsListViewModel.dart';
import 'package:tawjihi/Screens/Course/TestScreen.dart';
import 'package:tawjihi/Screens/Course/UnitsViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

import 'OptionsList.dart';

class CourseList extends StatelessWidget{
  String courseName="";
  CourseList(this.courseName);
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: MyText(
          "$courseName",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: body(context)

    );
  }

  Widget body(BuildContext context){
    return  Stack(children: <Widget>[
      ListView(
        children: <Widget>[
          viewCard(context, 'videos', Icons.video_library),
          viewCard(context, 'articles', Icons.assignment),
          viewCard(context, 'school_exams', Icons.content_paste),
          viewCard(context, 'work_papers', Icons.assignment_ind),
          viewCard(context, 'previous_exams', Icons.question_answer),
          viewCard(context, 'questions_topics', Icons.help),
        ],

      ),
      Positioned(
        bottom: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            startTestButton(context),
            SizedBox(height: 8,),
            questionsAndAnswrsButton(context)

          ],
        ),
      )

    ],);
  }

  Widget viewCard(BuildContext context,String title,IconData icon){
    return
      Card(
        elevation: 4,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
            ChangeNotifierProvider(
              create: (context)=>OptionsListViewModel(),
              child: OptionsList(title,courseName),
            )));
          },
          child: ListTile(
            title: MyText(title,style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
            leading: Container(height:double.infinity,child: Icon(icon,color: Colors.blue,size: 18,)),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
          ),
        ),
      );

  }

  Widget startTestButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8,right: 8),
      width: MediaQuery.of(context).size.width-16,
          height: 50,
          child: RaisedButton(
            color: ColorProperties.AppColorHex,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>UnitsViewModel(),
                    child: Units(),
                  )));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: MyText(
              "start",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
            ),
          ));
  }

  Widget questionsAndAnswrsButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8,right: 8),
        width: MediaQuery.of(context).size.width-16,
        height: 50,
        child: RaisedButton(
          color: Colors.white,
          textColor: ColorProperties.AppColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Units()));

          },
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorProperties.AppColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "qustions_answers",
            style: TextStyle(
                color: ColorProperties.AppColor,
                fontSize: 14,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700),
          ),
        ));
  }

}