import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  // static  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  //
  //   if (message.containsKey('notification')) {
  //     String sender;
  //     String parsedMessage;
  //     sender = message['notification']['title'];
  //     parsedMessage = message['notification']['body'];
  //     _showNotificationWithDefaultSound(sender,parsedMessage);
  //   }
  // }

  Future<void> init() async {

    configure();

    if (!_initialized) {
      // // For iOS request permission first.
      // _firebaseMessaging.requestNotificationPermissions();
      // _firebaseMessaging.configure();
      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      _initialized = true;
      print("FirebaseMessaging token: $token");

    }
  }

  configure(){
    _firebaseMessaging.subscribeToTopic("general");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        String sender;
        String parsedMessage;
        sender = message['notification']['title'];
        parsedMessage = message['notification']['body'];
        _showNotificationWithDefaultSound(sender,parsedMessage);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        String sender;
        String parsedMessage;
        sender = message['notification']['title'];
        parsedMessage = message['notification']['body'];
        _showNotificationWithDefaultSound(sender,parsedMessage);

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        String sender;
        String parsedMessage;
        sender = message['notification']['title'];
        parsedMessage = message['notification']['body'];
        _showNotificationWithDefaultSound(sender,parsedMessage);

      },
    );
  }

  static Future _showNotificationWithDefaultSound(String title, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        importance: Importance.max, priority: Priority.high,icon: "@mipmap/ic_launcher");
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics
    );
    await FlutterLocalNotificationsPlugin().show(
      0,
      '$title',
      '$message',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}