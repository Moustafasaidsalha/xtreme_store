import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:extreme_store/app/routes/routes_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  static late AndroidNotificationChannel channel;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static late FirebaseMessaging fcm;

  NotificationServices(FirebaseMessaging messaging) {
    fcm = messaging;
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'Thiss channel is used for important notifications.', // description
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> init() async {
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    await Permission.notification.isDenied.then((value) async {
      if (value) {
        await Permission.notification.request();
      }
    });
    String? token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('User Fcm token: $token');
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.subscribeToTopic('LeapDevTopic');
  }

  static Future<void> initLocal(BuildContext context) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) => onSelectForGroundNotification(payload, context),
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
    }
  }

  static Future<void> handelNotificationForeground(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
          payload: jsonEncode(message.data),

          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/ic_launcher',
                // other properties...
              ),
            ),
        );
      }
      // handleMessage(message, context);
    });
  }

  static Future<void> setupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage, context);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("onMessageOpenedApp");
      handleMessage(message, context);
    });
  }

  static void handleMessage(
    RemoteMessage message,
    BuildContext context,
  ) {
    if (kDebugMode) {
      print("handle message");
    }
    if (message.data.isNotEmpty) {
      notificationRedirect(context,message.data);
    }
  }

  static Future onSelectForGroundNotification(
    NotificationResponse notificationResponse,
    BuildContext context,
  ) async {
    if (kDebugMode) {
      print("local notification foreground");
      print("Payload ${notificationResponse.payload}");
    }
    var message = jsonDecode(notificationResponse.payload ?? '');
    notificationRedirect(context,message);
  }

 static void notificationRedirect(BuildContext context,dynamic message){
    if (message.isNotEmpty) {
      //notifyMy , orderStatus
      if (message['type'] == 'orderStatus') {
        if (message['order_id'] != null) {
          Navigator.of(context).pushNamed(
            RoutesConstant.trackOrder,
            arguments: int.tryParse(message['order_id']),
          );
        }
      } else if (message['type'] == 'notifyMy') {
        if (message['product_id'] != null) {
          Navigator.of(context).pushNamed(
            RoutesConstant.productDetails,
            arguments: [message['product_id']],
          );
        }
      }
    }

  }
}