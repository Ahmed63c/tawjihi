import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Course/CourseOptionsScreen.dart';
import 'package:tawjihi/Screens/Course/VideosScreen.dart';
import 'package:tawjihi/Screens/Course/VidesViewModel.dart';
import 'package:tawjihi/Screens/Course/WebViewList.dart';
import 'package:tawjihi/Screens/Course/WebViewListViewModel.dart';
import 'package:tawjihi/Screens/Settings/SettingsScreen.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:tawjihi/Utils/Constant.dart';

class HowToChooseScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: Text(
            AppLocalizations.of(context).translate("how_to"),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: "Cairo"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
            )
          ],
        ),
        body:list(context) ,
        floatingActionButton: speedDial()
    );
  }


  Widget list(BuildContext context){
    return
      ListView(
        children: [
          viewCard("schoolarShip", Image.asset(
            'assets/images/collegeGift.png',fit: BoxFit.cover,),context),
          viewCard("collegues", Image.asset(
            'assets/images/allCollege.png',fit: BoxFit.cover,),context),
          viewCard("specializatoin_how", Image.asset(
            'assets/images/spechializeChoose.png',fit: BoxFit.cover,),context)
    ]);
  }

  Widget speedDial() {
    return SpeedDial(
      marginRight: 32,
      marginBottom: 32,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.0,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.blue,
      foregroundColor: Colors.black,
      elevation: 8.0,
      animatedIcon: AnimatedIcons.home_menu,
      animatedIconTheme: IconThemeData(color: Colors.white),
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.mail),
            backgroundColor: Colors.red,
            onTap: () => print('FIRST CHILD')
        ),
        SpeedDialChild(
          child: Icon(Icons.call),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
        ),
      ],
    );
  }

  Widget viewCard(String name,Image image,BuildContext context) {
    return GestureDetector(
      onTap: ()
    {
      switch (name){
        case "schoolarShip":
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
              ChangeNotifierProvider(
                create: (context)=>WebViewListViewModel(),
                child: WebViewList("articles","how_to",Constant.HOW_TO_CHOOSE,Constant.COLLEGE_GIFT),
              )
          ));
          break;
        case "collegues":
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
              ChangeNotifierProvider(
                create: (context)=>WebViewListViewModel(),
                child: WebViewList("articles","how_to",Constant.HOW_TO_CHOOSE,Constant.ALL_COLLEGS),
              )
          ));                break;
        case "specializatoin_how":
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
              ChangeNotifierProvider(
                create: (context)=>WebViewListViewModel(),
                child: WebViewList("articles","how_to",Constant.HOW_TO_CHOOSE,Constant.SPECHIALIZE_CHOOSE),
              )
          ));
          break;
    }
      },
      child:Stack(children: <Widget>[
        Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: image),
        Positioned(
          bottom: 24,
          right: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 160,
                margin: EdgeInsets.only(bottom: 4, right: 32, left: 32),
                child: MyText(name,
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

}