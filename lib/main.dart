import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tawjihi/PushNotificationManger.dart';
import 'package:tawjihi/Screens/Login/LoginViewModel.dart';
import 'package:tawjihi/SplashScreen.dart';
import 'package:tawjihi/Utils/ColorProperties.dart';

import 'Screens/Login/LoginView.dart';
import 'Utils/AppLocalization.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PushNotificationsManager pushNotificationsManager=new PushNotificationsManager();
    pushNotificationsManager.init().then((value) => {
      pushNotificationsManager.configure
    });
    return MaterialApp(
      supportedLocales: [
//        Locale('en', 'US'),
         Locale('ar', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title:"Tawjihi",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:SplashScreen()
    );
  }
}