import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:touring_by/core/models/touring_by_initial_state.dart';

class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const channelId = "255";

  Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("touring_by_logo_no_bg");

    final InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings
    );
  }

  void showNotification({String title, String body, String payLoad}) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails( channelId, "aplicationName", "channelDescription");
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  Future<bool> localNotifificationLaunched () async {
    final NotificationAppLaunchDetails notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if(notificationAppLaunchDetails.didNotificationLaunchApp){
      return true;
      // int touringById = int.parse(notificationAppLaunchDetails.payload);
      // Navigator.pushNamed(context, "/take_tour", arguments: TouringByInitialState(touringById: touringById));
    }
    return false;

  }
}