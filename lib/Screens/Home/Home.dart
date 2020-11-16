import 'dart:io';

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
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  bool isLitery = false;

  Home(this.isLitery);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorProperties.AppColor,
          title: Text(
            AppLocalizations.of(context).translate("home"),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
            )
          ],
        ),
        body: isLitery ? homeAdby(context) : home(context),
        floatingActionButton: speedDial());
  }

  Widget tabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.blueAccent,
      labelColor: Colors.white,
      isScrollable: true,
      labelPadding: EdgeInsets.only(right: 14, left: 14),
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(
          child: Text(AppLocalizations.of(context).translate("main"),
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
        ),
        Tab(
          child: Text(AppLocalizations.of(context).translate("common"),
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
        ),
        Tab(
          child: Text(AppLocalizations.of(context).translate("guidance"),
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget home(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return ListView(
      shrinkWrap: true,
      children: [
        GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: itemWidth / itemHeight,
          children: <Widget>[
            tile(
              context,
              "math",
              Constant.MATH_ID_ALMY,
              Image.asset(
                'assets/images/math.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "biology",
              Constant.BIOLOGY_ID,
              Image.asset(
                'assets/images/biology.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "chemistry",
              Constant.CHEMISTRY_ID,
              Image.asset(
                'assets/images/chemistry.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "physics",
              Constant.PHYSICS_ID,
              Image.asset(
                'assets/images/physics.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        Divider(height: 100,)


      ],
    )
      ;
  }

  Widget homeAdby(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 220;
    final double itemWidth = 160;
    return
      ListView(
        shrinkWrap: true,
        children: [
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: itemWidth / itemHeight,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            tile(
              context,
              "math",
              Constant.MATH_ID,
              Image.asset(
                'assets/images/math.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "sci",
              Constant.SCIENTIFIC_CALTURE_ID,
              Image.asset(
                'assets/images/scientific_culture.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "history",
              Constant.HISTORY_ID,
              Image.asset(
                'assets/images/history.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "geo",
              Constant.GEOGRAPHIC_ID,
              Image.asset(
                'assets/images/geography.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "englishAdby",
              Constant.ENGLISH_ID_ADBY,
              Image.asset(
                'assets/images/english.png',
                fit: BoxFit.fill,
              ),
            ),
            tile(
              context,
              "arabicAdby",
              Constant.ARABIC_ID_ADBY,
              Image.asset(
                'assets/images/arabic.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        Divider(height: 100,)
      ],);
  }

  // Widget secondTab(BuildContext context) {
  //   var size = MediaQuery
  //       .of(context)
  //       .size;
  //   final double itemHeight = 220;
  //   final double itemWidth = 160;
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     childAspectRatio: itemWidth / itemHeight,
  //     children: <Widget>[
  //       tile(context, "english",Constant.ENGLISH_ID,Image.asset(
  //         'assets/images/english.png',
  //         fit: BoxFit.fill,
  //       ),),
  //       tile(context, "arabic",Constant.ARABIC_ID,Image.asset(
  //         'assets/images/arabic.png',
  //         fit: BoxFit.fill,
  //       ),),
  //       tile(context, "islamic", Constant.ISLAMIC_ID,Image.asset(
  //         'assets/images/islamic.png',
  //         fit: BoxFit.fill,
  //       ),),
  //       tile(context, "tech", Constant.TECH_ID,Image.asset(
  //         'assets/images/technology.png',
  //         fit: BoxFit.fill,
  //       ),),
  //     ],
  //   );
  // }
  //
  // Widget thirdTab(BuildContext context) {
  //   var size = MediaQuery
  //       .of(context)
  //       .size;
  //   final double itemHeight = 220;
  //   final double itemWidth = 160;
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     childAspectRatio: itemWidth / itemHeight,
  //     children: <Widget>[
  //       tile(context, "articles", Constant.GENRAL_VIDEOS_ARTICLES,Image.asset(
  //         'assets/images/articles.png',
  //         fit: BoxFit.fill,
  //       ),),
  //       tile(context, "videos", Constant.GENRAL_VIDEOS_ARTICLES,Image.asset(
  //         'assets/images/videos.png',
  //         fit: BoxFit.fill,
  //       ),),
  //     ],
  //   );
  // }

  Widget tile(
      BuildContext context, String courseName, int materialId, Image image) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CourseList(courseName, materialId)));
        },
        child: Stack(children: <Widget>[
          Container(height: double.infinity, child: image),
          Positioned(
            bottom: 30,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120,
                  margin: EdgeInsets.only(bottom: 4, right: 8, left: 8),
                  child: MyText(
                    courseName,
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: MyText(
                        "explore",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Cairo"),
                      )),
                )
              ],
            ),
          )
        ]),
      ),
    );
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
            onTap: () => _launchURL()),
        SpeedDialChild(
          child: Icon(Icons.call,color: Colors.white,),
          backgroundColor: Colors.green,
          onTap: () => launchWhatsApp(phone: "+970 599955706", message: "مرحبا"),
        ),
      ],
    );
  }


  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  void _launchURL() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'Twjihi2021@gmail.com',
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print( 'Could not launch $url');
    }
  }
}
