import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/QuestionsAndAnswersScreen.dart';
import 'package:tawjihi/Screens/Course/TestScreen.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class CourseList extends StatelessWidget{
  String appBarheader="";
  CourseList(this.appBarheader);
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: MyText(
          "$appBarheader",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(children: <Widget>[
        ListView(
          children: <Widget>[
            Card(
              elevation: 4,
              child: ListTile(
                title: MyText('videos',style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
                leading: Container(height:double.infinity,child: Icon(Icons.video_library,color: Colors.blue,size: 18,)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: MyText('articles',style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
                leading: Container(height:double.infinity,child: Icon(Icons.assignment,color: Colors.blue,size: 18,)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: MyText('school_exams',style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
                leading: Container(height:double.infinity,child: Icon(Icons.content_paste,color: Colors.blue,size: 18,)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: MyText('work_papers',style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
                leading: Container(height:double.infinity,child: Icon(Icons.assignment_ind,color: Colors.blue,size: 18,)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: MyText('previous_exams',style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
                leading: Container(height:double.infinity,child: Icon(Icons.question_answer,color: Colors.blue,size: 18,)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: MyText('questions_topics',style: TextStyle(fontFamily: "Cairo",fontSize: 18,fontWeight: FontWeight.w600),),
                leading: Container(height:double.infinity,child: Icon(Icons.polymer,color: Colors.blue,size: 18,)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,),
              ),
            ),


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

      ],)
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
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TestScreen()));
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
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>QAndAnswres()));

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