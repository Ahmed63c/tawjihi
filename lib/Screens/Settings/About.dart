import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class About extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: MyText(
            "about",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body(context)
    );
  }

  Widget body(BuildContext context) {
    return Container(
      child: aboutText(),
    );

  }


  Widget aboutText() {
    String test="حتى هاربر موسكو ثم, وتقهقر المنتصرة حدة عل, التي فهرست واشتدّت أن أسر. كانت المتاخمة التغييرات أم وفي. ان وانتهاءً باستحداث قهر. ان ضمنها للأراضي الأوروبية ذ";
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,top: 8),
      child: Text(test,
        style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500,
            fontSize: 16,color: Colors.black),),
    );
  }


}