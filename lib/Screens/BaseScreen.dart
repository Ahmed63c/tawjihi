import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';

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

}