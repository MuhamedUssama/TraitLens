import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trait_lens/core/cache/shared_preferences.dart';
import 'package:trait_lens/core/constants/app_constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log("Handling a background message: ${message.messageId}");
}

class FCM {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> fcmInit() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _handlePermissions();
    await _getToken();
    await _hadleForgroiundMessages();
  }

  static Future<void> _handlePermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      SharedPreferencesHelper.saveData(
        key: AppConstants.notificationsKey,
        value: true,
      );
      await FirebaseMessaging.instance.subscribeToTopic('general');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
      SharedPreferencesHelper.saveData(
        key: AppConstants.notificationsKey,
        value: true,
      );
      await FirebaseMessaging.instance.subscribeToTopic('general');
    } else {
      log('User declined or has not accepted permission');
      SharedPreferencesHelper.saveData(
        key: AppConstants.notificationsKey,
        value: false,
      );
      await FirebaseMessaging.instance.unsubscribeFromTopic('general');
    }
  }

  static Future<String?> _getToken() async {
    String? token = await messaging.getToken();
    log(token ?? 'No Token for this device');
    return token;
  }

  static Future<void> _hadleForgroiundMessages() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }
}
