import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class QAndAnswers extends StatefulWidget{
  String title;
  QAndAnswers(this.title);
  @override
  _QAndAnswersState createState() => _QAndAnswersState(title);
}

class _QAndAnswersState extends State<QAndAnswers> {
  String title;
  _QAndAnswersState(this.title);
  bool isVisble=false;




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: MyText(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: body(context),
    );

  }

  Widget body(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext c,int index){
        return QuestionCard(index);
      },
    );
  }

  Widget QuestionCard(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         questionNumber(),
         questionImage(),
         questionText(),
         divider(),
         answerText(),
         showAnswerButton()

       ],

      ),
    );

  }

 Widget questionNumber() {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 8),
      child: MyText("question_number",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w400,
          fontSize: 14,color: Colors.grey),),
    );
  }

  Widget questionImage() {
    return Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 8),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Image.asset("assets/images/logo.jpg",fit: BoxFit.fill,));
  }

  Widget questionText() {
    String test="(أ ب ج د) شبه منحرف فيه (اد)توازي(ب ج) وقياس زاوية (ب)=90 درجه فاذا كان  (اب)=3سم, (اد)= 6سم, (ب ج)="
        "(أ ب ج د) شبه منحرف فيه (اد)توازي(ب ج) وقياس زاوية (ب)=90 درجه فاذا كان  (اب)=3سم, (اد)= 6سم, (ب ج)=";
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 8),
      child: Text(test,
        style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500,
            fontSize: 16,color: Colors.black),),
    );
  }

 Widget showAnswerButton() {
    return    Container(
      margin: EdgeInsets.only(top: 32),
        child: FlatButton(
            color: Colors.transparent,
            textColor: Colors.blue,
            onPressed: () {
              setState(() {
               this.isVisble=isVisble?false:true;
              });

            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  isVisble?"إخفاء الإجابة":"إظهار الإجابة",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                    child: Icon(Icons.keyboard_arrow_down,size: 22,)),

              ],)
        ));

 }

  Widget answerText() {
    String test="(أ ب ج د) شبه منحرف فيه (اد)توازي(ب ج) وقياس زاوية (ب)=90 درجه فاذا كان  (اب)=3سم, (اد)= 6سم, (ب ج)="
        "(أ ب ج د) شبه منحرف فيه (اد)توازي(ب ج) وقياس زاوية (ب)=90 درجه فاذا كان  (اب)=3سم, (اد)= 6سم, (ب ج)=";
    return Visibility(
      visible: isVisble,
      child:
      Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 16),
        child: Text(test,
          style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500,
              fontSize: 16,color: Colors.black),),
      ),
    );
  }

 Widget divider() {
   return Visibility(
     visible: isVisble,
     child: Divider(
         color: Colors.grey,
         height: 32,
         thickness: 0.5,
         indent: 16,
         endIndent: 16,
     ),
   );
 }
}
