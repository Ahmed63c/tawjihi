import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/ImageDialoge.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/TestResultsScreen.dart';
import 'package:tawjihi/Screens/Course/TestViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:flutter_html/flutter_html.dart';


class TestScreen extends StatefulWidget {
  int materialId;
  int unitId;
  int quizId;

  TestScreen(this.materialId,this.unitId,this.quizId);
  @override
  _TestScreenState createState() => _TestScreenState(materialId,unitId,quizId);
}

class _TestScreenState extends State<TestScreen> with BaseScreen {
  int quizId;
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
  _TestScreenState(this.materialId,this.unitId,this.quizId);

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
               Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: MyText(
                    "choose",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.grey),
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
                            .push(MaterialPageRoute(builder: (_) =>
                            TestResultsScreen(corrctResult,wrongResult,materialId,unitId)));}
                      else{
                        questionNum++;
                        model.notifyListeners();
                      }
                      verifyAnswer=false;
                      verifyAnswerText=false;
                      choose="";

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
              nextButton(model),
            ],
          ),
        ),
    );
  }

  Widget questionImage(TestViewModel model) {
    if(model.test.details==null||model.test.details.isEmpty){
      return Container();
    }
    else {
      return
       Visibility(
         visible:model.test.details[questionNum].pics!=null&&model.test.details[questionNum].pics!="",
         child: GestureDetector(
           onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ImageDialog(
                 model.test.details[questionNum].pics==null
                 ? "" : model.test.details[questionNum].pics)
             ));
           },
           child: Card(
             elevation: 2,
             child:Column(
               children: [
                 Container(
                     margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                     child: Image(image: CachedNetworkImageProvider(model.test.details[questionNum].pics==null
                         ? "" : model.test.details[questionNum].pics),fit: BoxFit.contain,)
                 ),
               ],
             )

           ),
         ),
       );
    }
  }

  Widget questionText(TestViewModel model) {
    if(model.test.details==null||model.test.details.isEmpty){
      return Container();
    }
    else {
      return Directionality(
        textDirection:materialId==2?TextDirection.ltr:TextDirection.rtl,
        child: Container(
        margin: EdgeInsets.only(left: 84, right: 8, top: 8,bottom: 8),
        child:model.test.details[questionNum].title!=null?
        Html(data:model.test.details[questionNum].title,
          style: {
            "body": Style(
              fontSize: FontSize(16.0),
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
            ),
          },
        )
        :Container(),

            // TeXView(
            //   loadingWidgetBuilder:(context)=>Center(child: CupertinoActivityIndicator(radius: 10)),
            //   fonts: [TeXViewFont(fontFamily: "Cairo",src: "assets/fonts")],
            //   style: TeXViewStyle(contentColor: Colors.black,fontStyle:
            //   TeXViewFontStyle(fontSize: 18,fontFamily: "Cairo",fontWeight:TeXViewFontWeight.bold ) ),
            //   renderingEngine: TeXViewRenderingEngine.katex(),
            //   child: TeXViewContainer(child: TeXViewDocument(
            //       r""+model.test.details[questionNum].title,
            //       style: TeXViewStyle(textAlign: materialId==2?TeXViewTextAlign.Left:TeXViewTextAlign.Right)
            //   )),
            // ):
        // Text(
        //   model.test.details[questionNum].title,
        //   style: TextStyle(
        //       fontFamily: "Cairo",
        //       fontWeight: FontWeight.w700,
        //       fontSize: 16,
        //       color: Colors.black),
        // ),
    ),
      );
    }
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
      Directionality(
        textDirection:materialId==2?TextDirection.ltr:TextDirection.rtl,

        child: GestureDetector(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: 12,
                  height: 12,
                   decoration: BoxDecoration(shape: BoxShape.circle, color: getDotColor(answer, model.test.details[questionNum].correct_answer)),
                  child: getIcon(answer, model.test.details[questionNum].correct_answer),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: 250,
                  child:
                  Text(
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
        ),
      );
  }

  void getData(int materialId,int unitId){
    Map<String, dynamic> paramaters = new Map();
    paramaters.putIfAbsent("materialId", () => materialId);
    paramaters.putIfAbsent("unitId", () => unitId);
    paramaters.putIfAbsent("quizId", () => quizId);
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
        return Colors.grey[800];
      }    }

  }

  getDotColor(String answer,String correctAnswer) {
    if(!clicked&&verifyAnswer){
      if(choose==correctAnswer&&answer==choose){
        return Colors.green[900];
      }
      else if(answer!=correctAnswer&&answer==choose){
        return Colors.red[900];
      }
      else if (answer==correctAnswer&&answer!=choose){
        return Colors.green[900];
      }
    }
    else{
      if(answer==choose){
        return Colors.blue;
      }
      else{
        return Colors.grey;
      }
    }
  }

  Widget getIcon(String answer,String correctAnswer) {
    if(!clicked&&verifyAnswer){
      if(choose==correctAnswer&&answer==choose){
        return CircleAvatar(
            backgroundColor: Colors.green[900],
            child: Icon(Icons.check,color: Colors.white,size: 12,));
      }
      else if(answer!=correctAnswer&&answer==choose){
        return CircleAvatar(
            backgroundColor: Colors.red[900],
            child: Icon(Icons.close,color: Colors.white,size: 12,));
      }
      else if (answer==correctAnswer&&answer!=choose){
        return CircleAvatar(
            backgroundColor: Colors.green[900],
            child: Icon(Icons.check,color: Colors.white,size: 12,));
      }
      else{
        return Icon(Icons.fiber_manual_record,color: Colors.grey,size: 12,) ;
      }
    }
    else{
      if(answer==choose){
        return CircleAvatar(
          backgroundColor: Colors.blue,
            child: Icon(Icons.check,color: Colors.white,size: 12,));
      }
      else{
        return Icon(Icons.fiber_manual_record,color: Colors.grey,size: 12,) ;
      }
    }
  }
}
