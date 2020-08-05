import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class TestScreen extends StatefulWidget{
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[header()],
        ));

  }

 Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40,),
        Row(mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(margin: EdgeInsets.only(left: 16,right: 16),
              child: Icon(Icons.arrow_back,color: Colors.white,)),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
              child: MyText("multi_choice",style:
          TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Cairo"
          ,color: Colors.white),))

        ],),
        SizedBox(height: 32,),
        Row(mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 16,right: 16),
                child: MyText("question_number",style:
                TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Cairo"
                    ,color: Colors.white),)),
            Container(
                child: Text("49/50",style:
                TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Cairo"
                    ,color: Colors.white),))


          ],),
        SizedBox(height: 24,),
        Container(
          margin: EdgeInsets.only(left: 16,right: 16),
           child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff2397FC),),
                  value: 0.9,
              ),
         ),
        testCard()
      ],
    );

 }
 Widget testCard() {
    return Flexible(
      child: Stack(
        children: <Widget>[
         backGround(),
          ListView(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 8),
              child: Text("اختر الاجابة الصحيه",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w400,
                  fontSize: 14,color: Colors.grey),),
            ),
            questionImage(),
            questionText(),
            questionAnswers(),
            SizedBox(height: 100,)

          ],),
          bottomActions()
        ],
      ),
    );
 }

  Widget nextButton() {
    return Container(
            height: 40,
              width: 110,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: RaisedButton(
                onPressed: (){},
                  color: ColorProperties.AppColorHex,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 4,right: 4,bottom: 4),
                        child: MyText(
                          "next",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 4,right: 4),
                          child: Icon(Icons.arrow_forward_ios,size: 14,))
                    ],)
              ));
  }

  Widget previousButton() {
    return Container(
              height: 40,
              width: 110,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: RaisedButton(
                  onPressed: (){},
                  color: ColorProperties.AppColorHex,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 4,right: 4),
                          child: Icon(Icons.arrow_back_ios,size: 14,)),
                      Container(
                        margin: EdgeInsets.only(left: 4,right: 4,bottom: 4),
                        child: MyText(
                          "previous",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],)
              ));
  }

  Widget backGround() {
    return  Container(
      margin: EdgeInsets.only(top: 24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    );
  }

  Widget bottomActions() {
    return Positioned(
      bottom: 16,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Colors.white60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            previousButton(),
            nextButton(),

          ],
        ),
      ),

    );
  }

  Widget questionImage() {
    return Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 8),
        height: 80,
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

  Widget  questionAnswers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        questionCell("answer"),questionCell("answer"),
        questionCell("answer"),questionCell("answer"),
      ],
    );
  }


  Widget questionCell(String answer){
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 8),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))

        ),
        child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16,right: 16),
              width: 12,height: 12,decoration:
            BoxDecoration(shape: BoxShape.circle,color: Colors.grey),),
            Container(
              margin: EdgeInsets.only(left: 16,right: 16),
              child: Text("25 سم",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w400,
                  fontSize: 18,color: Colors.grey),),
            ),
          ],),
      ),
    );
  }


}