import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Settings/About.dart';
import 'package:tawjihi/Screens/Settings/ChangPassword.dart';
import 'package:tawjihi/Screens/Settings/ChangeLanguage.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorProperties.AppColor,
        title: MyText(
          "settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
        body: body(context)
    );
  }

 Widget body(BuildContext context) {
    return ListView(
      children: <Widget>[
        title("language"),
        settingsCard(context, "change_language", Icons.language),
        title("security"),
        settingsCard(context, "change_password", Icons.lock),
        title("more"),
        settingsCard(context, "about", Icons.assignment),

      ],
    );
 }

 Widget title(String title) {
    return Container(
      height: 32,
      decoration: BoxDecoration(color: Color(0x11707070)),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
        child: MyText(title,
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey)),
      ),
    );
 }

  Widget settingsCard(BuildContext context,String title,IconData icon){
    return
      Card(
        elevation: 4,
        child: GestureDetector(
          onTap: (){
            switch (title){
              case "change_language":
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChangeLanguage()));
                break;
              case "change_password":
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChangePassword()));

                break;
              case "about":
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>About()));
                break;
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


}