import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/Screens/Home/Home.dart';
import 'package:tawjihi/Screens/Login/LoginView.dart';
import 'package:tawjihi/Screens/Login/LoginViewModel.dart';

import 'Screens/Home/MainScreen.dart';
import 'Utils/Constant.dart';
import 'Utils/LocalStorage.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => handleNavigation());

  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child:  Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/logo.jpg'), fit: BoxFit.cover)),),
    );
  }

  handleNavigation() {
    StorageUtil.getInstance().then((storage){
      String major=StorageUtil.getString(Constant.MAJOR);
      if(StorageUtil.getString(Constant.LOGGED_IN)==Constant.APP_VERSION&&StorageUtil.getBool(Constant.ACTIVE)){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => MainScreen(major == "scientific"
                    ? false
                    : true)));

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) =>ChangeNotifierProvider(
        //       create: (context)=>LoginViewModel(),
        //       child: LoginView(),))
        // );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>ChangeNotifierProvider(
          create: (context)=>LoginViewModel(),
          child: LoginView(),))
        );

      }
    });
  }
}