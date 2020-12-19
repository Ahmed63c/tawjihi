import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Network/BaseApiResponse.dart';
import 'package:tawjihi/Screens/BaseScreen.dart';
import 'package:tawjihi/Screens/ComonWidget/ImageDialoge.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/QuestionsAndAnswersViewModel.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class QAndAnswers extends StatefulWidget{
  String title;
  int materialId;
  int unitId;
  int sectionId;
  int quizId;
  QAndAnswers(this.title,this.materialId,this.unitId,this.sectionId,this.quizId);
  @override
  _QAndAnswersState createState() => _QAndAnswersState(title,materialId,unitId,sectionId,quizId);
}

class _QAndAnswersState extends State<QAndAnswers> with BaseScreen {
  String title;
  int materialId;
  int unitId;
  int sectionId;
  int quizId;
  _QAndAnswersState(this.title,this.materialId,this.unitId,this.sectionId,this.quizId);
  bool isVisble=false;

  @override
  Widget build(BuildContext context) {

    getData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:  Stack(
        children: <Widget>[
          Consumer<QuestionsAndAnswersViewModel>(
              builder: (context, model, child) {
                return switchWidgets(model, context);
              })
        ],
      )
    );

  }

  Widget body(QuestionsAndAnswersViewModel model) {
    return ListView.builder(
      itemCount: model.QAndAnswers.details.length,
      itemBuilder: (BuildContext c,int index){
        return QuestionCard(index,model);
      },
    );
  }

  Widget QuestionCard(int index,QuestionsAndAnswersViewModel model) {
    return Card(
      elevation: 16,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child:
      Column(
        mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         questionNumber(model,index),
         questionText(model,index),
         questionImage(model,index),
         divider(),
         Child(model, index,materialId)
       ],

      ),
    );

  }

 Widget questionNumber(QuestionsAndAnswersViewModel model,int index) {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 8),
      child: Row(
        children: <Widget>[
          MyText("question_number",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w400,
              fontSize: 14,color: Colors.grey,decoration: TextDecoration.underline),),
          Text(" ${index+1} :",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w400,
              fontSize: 14,color: Colors.grey,decoration: TextDecoration.underline),),
        ],
      )
    );
  }

  Widget questionImage(QuestionsAndAnswersViewModel model,int index) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ImageDialog(model.QAndAnswers.details[index].pics==null
            ? "" : model.QAndAnswers.details[index].pics)));
      },
      child: Visibility(
        visible: model.QAndAnswers.details[index].pics!=null,
        child:
        Card(
          elevation: 10,
          child:
         Column(children: [
           Container(
             margin: EdgeInsets.only(left: 16,right: 16,top: 8),
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
             child:  Image(image: CachedNetworkImageProvider(model.QAndAnswers.details[index].pics==null?"":
             model.QAndAnswers.details[index].pics),fit: BoxFit.fill,),
           ),
         ],)
        ),
      ),
    );
  }

  Widget questionText(QuestionsAndAnswersViewModel model,int index) {
    return Visibility(
      visible:model.QAndAnswers.details[index].title!=null ,
      child: Directionality(
        textDirection:materialId==2?TextDirection.ltr:TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 8),
          child:model.QAndAnswers.details[index].title==null?Container():
          Html(data: model.QAndAnswers.details[index].title,
            style: {
              "body": Style(
                  fontSize: FontSize(16.0),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                  color: Colors.black
              ),
            },
          ),
          // TeXView(
          //   fonts: [TeXViewFont(fontFamily: "Cairo",src: "assets/fonts")],
          //   style: TeXViewStyle(contentColor: Colors.black,fontStyle:
          //   TeXViewFontStyle(fontSize: 16,fontFamily: "Cairo",fontWeight:TeXViewFontWeight.bold,),
          //       backgroundColor: Colors.white ),
          //   renderingEngine: TeXViewRenderingEngine.katex(),
          //   loadingWidgetBuilder:(context)=>Center(child: CupertinoActivityIndicator(radius: 10)),
          //   child: TeXViewContainer(child: TeXViewDocument(
          //       model.QAndAnswers.details[index].title,
          //       style: TeXViewStyle(textAlign: materialId==2?TeXViewTextAlign.Left:TeXViewTextAlign.Right)
          //   )),
          // ),
          // Text(model.QAndAnswers.details[index].title==null?"":
          // model.QAndAnswers.details[index].title,
          //   style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w700,
          //       fontSize: 15,color: Colors.black),),
        ),
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

  Widget switchWidgets(QuestionsAndAnswersViewModel model, BuildContext context) {
    switch (model.QAndAnswersResponseWraper.status) {
      case Status.LOADING:
        return super.loadingIndicator(
            model.QAndAnswersResponseWraper.status == Status.LOADING, context);
        break;
      case Status.empty:
        return super.loadingIndicator(
            model.QAndAnswersResponseWraper.status == Status.empty, context);

      case Status.ERROR:
        return Visibility(
          visible: model.QAndAnswersResponseWraper.status == Status.ERROR,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                model.error,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo",
                    color: Colors.red),
              )),
        );
        break;
      case Status.COMPLETED:
        return model.QAndAnswers.details.length > 0
            ? body(model)
            : Container(
          child: Center(
            child: MyText(
              "error_empty",
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
        );
        break;
    }

  }

  void getData() {
    Map<String,dynamic> paramaters=new Map();
    paramaters.putIfAbsent("materialId", () =>materialId);
    paramaters.putIfAbsent("unitId", () => unitId);
    paramaters.putIfAbsent("sectionId", () => sectionId);
    paramaters.putIfAbsent("quizId", () => quizId);
    Provider.of<QuestionsAndAnswersViewModel>(context,listen: false).get(paramaters);
  }

}


class Child extends StatefulWidget {
  QuestionsAndAnswersViewModel model;
  int index;
  int materialId;
  Child(this.model,this.index,this.materialId);
  @override
  ChildState createState() => ChildState(model,index,materialId);
}

class ChildState extends State<Child> {
  QuestionsAndAnswersViewModel model;
  int index;
  bool isVisble=false;
  int materialId;
  ChildState(this.model,this.index,this.materialId);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Colors.blue,
          height: 32,
          thickness: 1,
          indent: 32,
          endIndent: 32,
        ),
        answerImage(model,index),
        answerText(model,index,materialId),
        showAnswerButton()

      ],
    );
  }

  Widget showAnswerButton() {
    return Container(
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
                MyText(
                  isVisble?"hide_answer":"show_answer",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w500),
                ),
                Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Icon(Icons.keyboard_arrow_down,size: 22,)),

              ],)
        ));

  }

  Widget answerImage(QuestionsAndAnswersViewModel model,int index) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ImageDialog(model.QAndAnswers.details[index].answer_pic==null
            ? "" : model.QAndAnswers.details[index].answer_pic)));
      },
      child: Visibility(
        visible: isVisble&&model.QAndAnswers.details[index].answer_pic!=null,
        child:
        Card(
          elevation: 10,
            child:
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
              Container(
                margin: EdgeInsets.only(left: 16,right: 16,top: 8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child:  Image(image: CachedNetworkImageProvider(model.QAndAnswers.details[index].answer_pic==null?
                "":model.QAndAnswers.details[index].answer_pic,),fit: BoxFit.contain,),
              ),
            ],)
        ),
      ),
    );
  }

  Widget answerText(QuestionsAndAnswersViewModel model,int index,int materialID) {
    return Visibility(
      visible: isVisble,
      child:
      Directionality(
        textDirection:materialID==2?TextDirection.ltr:TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 16),
          child: model.QAndAnswers.details[index].answer==null?Container():
          Html(data: model.QAndAnswers.details[index].answer,
            style: {
              "body": Style(
                  fontSize: FontSize(18.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                  color: Colors.black
              ),
            },
          )
          // TeXView(
          //   loadingWidgetBuilder:(context)=>Center(child: CupertinoActivityIndicator(radius: 10)),
          //   fonts: [TeXViewFont(fontFamily: "Cairo",src: "assets/fonts")],
          //   style: TeXViewStyle(contentColor: Colors.black,fontStyle:
          //   TeXViewFontStyle(fontSize: 18,fontFamily: "Cairo",fontWeight:TeXViewFontWeight.w300 ) ),
          //   renderingEngine: TeXViewRenderingEngine.katex(),
          //   child: TeXViewContainer(child: TeXViewDocument(
          //       r""+model.QAndAnswers.details[index].answer,
          //       style: TeXViewStyle(textAlign: materialId==2?TeXViewTextAlign.Left:TeXViewTextAlign.Right)
          //   )),
          // ),

          // Text(model.QAndAnswers.details[index].answer==null?"":
          // model.QAndAnswers.details[index].answer,
          //   style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500,
          //       fontSize: 16,color: Colors.black),),
        ),
      ),
    );
  }
}
