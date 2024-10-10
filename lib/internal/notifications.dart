import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/router.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      GetIt.I.get<Talker>().debug(
            'Payload: $payload',
          );
      Map values = jsonDecode(payload as String);
      router.goNamed('noti_task', queryParameters: {
        'name': values['name'],
        'desc': values['desc'],
      });
    }
  }

  static Future<void> onDidReceiveBackgroundNotificationResponse(
      String? payload) async {
    if (payload != null) {
      GetIt.I.get<Talker>().debug(
            'Payload: $payload',
          );
      Map values = jsonDecode(payload);
      router.goNamed('noti_task', queryParameters: {
        'name': values['name'],
        'desc': values['desc'],
      });
    }
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
    );
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await NotificationService.flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
      if (notificationAppLaunchDetails?.notificationResponse != null) {
        onDidReceiveBackgroundNotificationResponse(notificationAppLaunchDetails!
            .notificationResponse!.payload
            .toString());
      }
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'instant_notification',
    );
  }

  static Future<void> scheduleNotification(int id, String title, String body,
      DateTime scheduledTime, String? payload) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      payload: payload,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Channel',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
