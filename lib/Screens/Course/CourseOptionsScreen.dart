import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/Units.dart';
import 'package:tawjihi/Screens/Course/VidesViewModel.dart';
import 'package:tawjihi/Screens/Course/WebViewListViewModel.dart';
import 'package:tawjihi/Screens/Course/TestScreen.dart';
import 'package:tawjihi/Screens/Course/UnitsViewModel.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';

import 'VideosScreen.dart';
import 'WebViewList.dart';

class CourseList extends StatelessWidget{
  String courseName="";
  bool fromTest=true;
  bool fromQA=false;
  int materialId;
  CourseList(this.courseName,this.materialId);
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
       //   viewCard(context, 'school_exams', Icons.content_paste,Constant.SCHOOL_EXAMS_ID),
        //  viewCard(context, 'work_papers', Icons.assignment_ind,Constant.PAPERS_ID),
          viewCard(context, 'previous_exams', Icons.question_answer,Constant.PREVIOUS_EXAMS_ID),
          viewCard(context, 'questions_topics', Icons.help,Constant.QUESTION_TOPICS_ID),
          //viewCard(context, 'articles', Icons.lock,Constant.ARTICLES_ID),
         // viewCard(context, 'videos', Icons.lock,0),
          SizedBox(
            height: 200,
          )
        ],

      ),
      Positioned(
        bottom: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            startTestButton(context),
            SizedBox(height: 20,),
            questionsAndAnswrsButton(context),
            SizedBox(height: 50,)


          ],
        ),
      )

    ],);
  }

  Widget viewCard(BuildContext context,String title,IconData icon,int type){
    return
      Card(
        elevation: 4,
        child: GestureDetector(
          onTap: (){
            if(type==0||type==1){
              // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
              //     ChangeNotifierProvider(
              //       create: (context)=>VideosViewModel(),
              //       child: Videos(title,courseName,materialId,type),
              //     )
              // ));
            }
            else{
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>WebViewListViewModel(),
                    child: WebViewList(title,courseName,materialId,type),
                  )
              )
              );
            }

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
          height: 140,
          child: MaterialButton(
            color: ColorProperties.AppColorHex,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                  ChangeNotifierProvider(
                    create: (context)=>UnitsViewModel(),
                    child: Units(fromTest,materialId),
                  )));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: MyText(
              "start",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
            ),
          ));
  }

  Widget questionsAndAnswrsButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8,right: 8),
        width: MediaQuery.of(context).size.width-16,
        height: 140,
        child: MaterialButton(
          color: Colors.white,
          textColor: ColorProperties.AppColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
             ChangeNotifierProvider(
               create: (context)=>UnitsViewModel(),
               child: Units(fromQA,materialId),
             )
            ));

          },
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorProperties.AppColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "qustions_answers",
            style: TextStyle(
                color: ColorProperties.AppColor,
                fontSize: 18,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700),
          ),
        ));
  }

}