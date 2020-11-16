import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/NumberOfTestScreen.dart';
import 'package:tawjihi/Screens/Course/NumberOfTestsViewModel.dart';
import 'package:tawjihi/Screens/Course/TestViewModel.dart';
import 'package:tawjihi/Screens/Course/UnitsViewModel.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/Home/MainScreen.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';
import 'package:tawjihi/Utils/LocalStorage.dart';

import 'Units.dart';
import 'TestScreen.dart';

class TestResultsScreen extends StatefulWidget{
  int correctResult;
  int wrongResult;
  int materialId;
  int unitId;


  TestResultsScreen(this.correctResult,this.wrongResult,this.materialId,this.unitId);
  @override
  _TestResultsScreenState createState() => _TestResultsScreenState(correctResult,wrongResult,materialId,unitId);
}

class _TestResultsScreenState extends State<TestResultsScreen> {
  int correctResult;
  int wrongResult;
  int materialId;
  int unitId;

  _TestResultsScreenState(this.correctResult,this.wrongResult,this.materialId,this.unitId);
  @override
  Widget build(BuildContext context) {
    print(correctResult);
    print(wrongResult);
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
                child: GestureDetector(
                  onTap: (){
                    StorageUtil.getInstance().then((storage){
                     String major= StorageUtil.getString(Constant.MAJOR);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>
                          MainScreen(major=="literature"?true:false)));
                    });

                  },
                    child: Icon(Icons.arrow_back,color: Colors.white,))),
            Container(
                margin: EdgeInsets.only(left: 16,right: 16),
                child: MyText("test_results",style:
                TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Cairo"
                    ,color: Colors.white),))

          ],),
        SizedBox(height: 32,),
        testResultCard()
      ],
    );

  }
  Widget testResultCard() {
    return Flexible(
      child: Stack(
        children: <Widget>[
          backGround(),
          ListView(children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 32),
                child: MyText("test_results",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w700,
                    fontSize: 18,color: Colors.black),),
              ),
            ),
            SizedBox(height: 32),
            Row(mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              answerResultContainer("correct_answers","green"),
              answerResultContainer("wrong_answers","red"),
            ],)

          ],),
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
        ],
      ),
    );
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
                  create: (context)=>NumberOfTestsViewModel(),
                  child: NumberOfTestsScreen(materialId,unitId),
                )));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: MyText(
            "start_new",
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
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                ChangeNotifierProvider(
                  create: (context)=>UnitsViewModel(),
                  child: Units(false,materialId),
                )));

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

  Widget answerResultContainer(String header,String color){
    return Container(
      width: 152,
      height: 170,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color:color=="red"?Colors.red:Colors.green, borderRadius: BorderRadius.circular(8)),
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyText(
              "$header",
              style: TextStyle(
                  color:Colors.white,
                  fontSize: 18,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24,),
            Text(
              color=="green"?"$correctResult":"$wrongResult",
              style: TextStyle(
                  color:Colors.white,
                  fontSize: 24,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),


          ],
        ),
    );


  }

}