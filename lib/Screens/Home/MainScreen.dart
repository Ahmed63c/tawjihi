import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:system_shortcuts/system_shortcuts.dart';
import 'package:tawjihi/Screens/ComonWidget/Text.dart';
import 'package:tawjihi/Screens/Home/GuidenessScreens.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/Settings/SettingsScreen.dart';
import 'package:tawjihi/Utils/AppLocalization.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

import 'CommonMaterials.dart';
import 'HowToChooseScreen.dart';

class MainScreen extends StatefulWidget {
  bool isLiteral;
  MainScreen(this.isLiteral);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>SystemShortcuts.home(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          automaticallyImplyLeading: false,
          elevation: 0,
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
        body: body(context),
          floatingActionButton: speedDial(context)

      ),
    );
  }

 Widget body(BuildContext context) {
    return Material(
      color: ColorProperties.AppColor,
      child:
      ListView(
        children: [
          headerLogo(),
          viewCard("main", Image.asset(
              'assets/images/mainMaterials.png',fit: BoxFit.fill,),context),
          viewCard("common", Image.asset(
            'assets/images/common.png',fit: BoxFit.fill,),context),
          viewCard("guidance", Image.asset(
            'assets/images/guide.png',fit: BoxFit.fill,),context),
          viewCard("how_to", Image.asset(
            'assets/images/howToChoose.png',fit: BoxFit.fill,),context),

        ],
      ),
    );
 }

  Widget headerLogo() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/images/tawjihi_logo.png")),
    );
  }

 Widget viewCard(String name,Image image,BuildContext context) {
    return GestureDetector(
      onTap: (){
        switch (name){
          case "main":
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Home(true)));
            break;
          case "common":
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CommonMaterials()));
            break;
          case "guidance":
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>GuidenessScreen()));
            break;

          case "how_to":
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HowToChooseScreen()));
            break;

        }
      },
      child:   Stack(children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 12,left: 24,right: 24),
            height: 90,
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

  Widget speedDial(BuildContext context) {
    return SpeedDial(
      marginRight: 32,
      marginBottom: 16,
      closeManually: false,
      curve: Curves.ease,
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

  // @override
  // Future<bool> didPopRoute() async {
  //   await SystemShortcuts.home();
  //   return true;
  // }
}