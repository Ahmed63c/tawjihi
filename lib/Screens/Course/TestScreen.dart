import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/ImageDialoge.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/TestResultsScreen.dart';
import 'package:tawjihi/Screens/Course/TestViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class TestScreen extends StatefulWidget {
  int materialId;
  int unitId;

  TestScreen(this.materialId,this.unitId);
  @override
  _TestScreenState createState() => _TestScreenState(materialId,unitId);
}

class _TestScreenState extends State<TestScreen> with BaseScreen {

  int questionNum=0;
  int corrctResult=0;
  int wrongResult=0;
  int questionLenght=0;
  Color rightAnswer=Colors.green;
  Color wrongAnswer=Colors.red;
  Color emptyAnswer=Colors.white;
  Color selectedAnswer=ColorProperties.AppColor;
  bool clicked=false;
  bool verifyAnswer=false;
  bool verifyAnswerText=false;

  String choose="";
  int materialId;
  int unitId;
  _TestScreenState(this.materialId,this.unitId);

  @override
  Widget build(BuildContext context) {
    var model=Provider.of<TestViewModel>(context,listen: false);
    getData(materialId,unitId);

    return Material(
        color: ColorProperties.AppColor,
        child: Stack(
          children: <Widget>[
            header(model),
            Consumer<TestViewModel>(builder: (context, model, child) {
              return super.loadingIndicator(model.testResponseWraper.status==Status.LOADING, context);
            }
            ),
            Consumer<TestViewModel>(builder: (context, model, child) {
              return super.errorScreen(model.testResponseWraper.status==Status.ERROR, context);
            }
            ),
          ],
        ));
  }

  Widget header(TestViewModel model) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: MyText(
                    "multi_choice",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Cairo",
                        color: Colors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: MyText(
                    "question_number",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Cairo",
                        color: Colors.white),
                  )),
           Container(
             constraints: BoxConstraints(maxHeight: 32,maxWidth: 64),
             child: Consumer<TestViewModel>(builder: (context,model,child){
               return model.testResponseWraper.status==Status.COMPLETED? Container(
                   child: Text(
                     "${questionNum+1}/${model.test.details.length}",
                     style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.w700,
                         fontFamily: "Cairo",
                         color: Colors.white),
                   )):Container();
             },),
           )
            ],
          ),
          SizedBox(
            height: 24,
          ),
         Container(
           constraints: BoxConstraints(maxHeight:32,maxWidth: 200 ),
           child: Consumer<TestViewModel>(builder: (context,model,child){
             return model.testResponseWraper.status==Status.COMPLETED?Container(
               margin: EdgeInsets.only(left: 16, right: 16),
               child: LinearProgressIndicator(
                 backgroundColor: Colors.white,
                 valueColor: AlwaysStoppedAnimation<Color>(
                   Color(0xff2397FC),
                 ),
                 value:model.test.details.length==0? 0.0:((questionNum+1))/model.test.details.length,
               ),
             ):Container();
           },),
         ),
          testCard(model)
        ],
    );
  }

  Widget testCard(TestViewModel model) {
    return Flexible(
      child: Stack(
        children: <Widget>[
          backGround(),
          Consumer<TestViewModel>(builder: (context, model, child) {
        return Visibility(
          visible: model.testResponseWraper.status==Status.COMPLETED,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Visibility(
                visible: model.testResponseWraper.status==Status.COMPLETED&&model.test.details.length>0,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: MyText(
                    "choose",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                ),
              ),
              questionImage(model),
              questionText(model),
              questionAnswers(model),
              SizedBox(
                height: 100,
              )
            ],
          ),
        );
      }),
          bottomActions(model)
        ],
      ),
    );
  }

  Widget nextButton(TestViewModel model) {
    return

      Consumer<TestViewModel>(builder: (context, model, child) {
        return Container(
            height: 40,
            width: 110,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: RaisedButton(
                onPressed: () {
                  if(clicked){
                    verifyAnswer=true;
                    verifyAnswerText=true;
                    clicked=false;
                    model.notifyListeners();
                  }

                  else{
                    if(verifyAnswer){
                      if((questionNum+1)==model.test.details.length){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => TestResultsScreen(corrctResult,wrongResult,materialId,unitId)));}
                      else{
                        questionNum++;
                        model.notifyListeners();
                      }
                      verifyAnswer=false;
                      verifyAnswerText=false;

                    }

                  }



                },
                color: ColorProperties.AppColorHex,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
                      child: MyText(
                        verifyAnswerText?"next":"verify_answer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 4, right: 4),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ))
                  ],
                )));
      }
      );
  }

  Widget previousButton() {
    return Visibility(
      visible: false,
      child: Container(
          height: 40,
          width: 110,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                //decrase conunter if it is not 0
              },
              color: ColorProperties.AppColorHex,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 14,
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
                    child: MyText(
                      "previous",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ))),
    );
  }

  Widget backGround() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    );
  }

  Widget bottomActions(TestViewModel model) {
    return Visibility(
      visible: model.testResponseWraper.status==Status.COMPLETED&&model.test.details.length>0,
      child: Positioned(
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
              nextButton(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionImage(TestViewModel model) {
    if(model.test.details==null||model.test.details.isEmpty){
      return Container();
    }
    else
    return
       GestureDetector(
         onTap: (){

           Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ImageDialog(model.test.details[questionNum].pics==null
               ? "" : model.test.details[questionNum].pics)
           ));
         },
         child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            height: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image(image: CachedNetworkImageProvider(model.test.details[questionNum].pics==null
                ? "" : model.test.details[questionNum].pics),fit: BoxFit.contain,)
    ),
       )
    ;
  }

  Widget questionText(TestViewModel model) {
    String test ="";
    if(model.test.details==null||model.test.details.isEmpty){
      return Container();
    }
    else
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Text(
        model.test.details[questionNum].title,
        style: TextStyle(
            fontFamily: "Cairo",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black),
      ),
    );
  }

  Widget questionAnswers(TestViewModel model) {
    if(model.test.details==null||model.test.details.isEmpty){
      return Container();
    }
    else
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
    StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: <Widget>[
          questionCell(model.test.details[questionNum].answer1,model),
          questionCell(model.test.details[questionNum].answer2,model),
          questionCell(model.test.details[questionNum].answer3,model),
          questionCell(model.test.details[questionNum].answer4,model),

        ],
      );
    }
    ),
            ],
    );
  }

  Widget questionCell(String answer,TestViewModel model) {
    return
      GestureDetector(
        onTap: (){
            clicked=true;
            choose=answer;
            model.notifyListeners();
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              color:answerColor(answer, model.test.details[questionNum].correct_answer),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: 12,
                height: 12,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                answer,
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: answerTextColor(answer, model.test.details[questionNum].correct_answer),
                ),
              ),
              )],
          ),
        ),
      );
  }

  void getData(int materialId,int unitId){
    Map<String, dynamic> paramaters = new Map();
    paramaters.putIfAbsent("materialId", () => materialId);
    paramaters.putIfAbsent("unitId", () => unitId);
    Provider.of<TestViewModel>(context, listen: false).get(paramaters);
  }

   answerColor(String answer,String correctAnswer) {
    if(!clicked&&verifyAnswer){
        if(choose==correctAnswer&&answer==choose){
          corrctResult++;
          return rightAnswer;
        }
        else if(answer!=correctAnswer&&answer==choose){
          wrongResult++;
          return wrongAnswer;
        }
        else if (answer==correctAnswer&&answer!=choose){
          return rightAnswer;
        }
    }

    else{
      if(answer==choose){
        return ColorProperties.AppColor;
      }
      else{
        return Colors.white;
      }

    }



    }

  answerTextColor(String answer,String correctAnswer) {
    Color color=Colors.grey;
    if(!clicked&&verifyAnswer){
      if(choose==correctAnswer&&answer==choose){
        color=Colors.white;
        return color;
      }
      else if(answer!=correctAnswer&&answer==choose){
        color=Colors.white;
        return color;
      }
      else if (answer==correctAnswer&&answer!=choose){
        color=Colors.white;
        return color;
      }
    }
    else{
      if(answer==choose){
        return Colors.white;
      }
      else{
        return Colors.grey;
      }    }

  }

//  void showDialogeImage(String image) {
//
//    showGeneralDialog(
//      context: context,
//      barrierColor: Colors.black12.withOpacity(0.6), // background color
//      barrierDismissible: false, // should dialog be dismissed when tapped outside
//      transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
//      pageBuilder: (_, __, ___) { // your widget implementation
//        return
//          SizedBox.expand( // makes widget fullscreen
//          child:
//          Stack(
//            children: [
//              Container(
//                    margin: EdgeInsets.only(top: 32,right: 32),
//                    child:  IconButton(
//                      icon: Icon(Icons.clear,color: Colors.red,size: 32,),
//                      onPressed: (){
//                        Navigator.pop(context);
//                      },
//                    )),
//              Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: CachedNetworkImageProvider(image),fit: BoxFit.contain,
//                    )
//                ),
//              )
//            ],
//          ),
//        );
//      },
//    );
//  }


}
