import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

mixin BaseScreen {
  Widget loadingIndicator(bool isLoading,BuildContext context){
     return Visibility(
          visible:isLoading,
          child:Stack(children: <Widget>[
            Container(width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black26,),
            Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ CupertinoActivityIndicator(radius: 16,),MyText("loading")])),

          ],),
     );


  }

  Widget errorScreen(bool error,BuildContext context){
    return Visibility(
      visible: error,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            "error_title",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: MyText("error",
            style:
            TextStyle(fontSize: 18,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),),
          ),
        ),
      ),
    );
  }

}