import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {

  // initialization Notification
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: false,
      badge: true,
      sound: true,
    );

    // click on notification
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTapNotification,
        onDidReceiveBackgroundNotificationResponse: onTapNotification
    );

  }


  // basic Notification
  static Future<void> showBasicNotification({
    required String title,
    required String body
  }) async {

    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      // for show notification in side app not in notification list {importance - priority}
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics
    );

    /// details of notification
    await FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  // repeated Notification
  static Future<void> showRepeatedNotification({
    required String title,
    required String body
  }) async {

    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      // for show notification in side app not in notification list {importance - priority}
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics
    );

    /// details of notification
    await FlutterLocalNotificationsPlugin().periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.hourly,
      platformChannelSpecifics,
      // to ensure send notification if phone in save battery mode || use inexact if not necessary to show
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'item x',
    );
  }

  // // repeated Notification
  // static Future<void> showScheduledNotification({
  //   required String title,
  //   required String body
  // }) async {
  //
  //   AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     // for show notification in side app not in notification list {importance - priority}
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //
  //   NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics
  //   );
  //
  //   log('Before ${tz.Location}');
  //   log('Before ${tz.TimeZone}');
  //   final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  //   tz.initializeTimeZones();
  //   tz.setLocalLocation(tz.getLocation(currentTimeZone));
  //   log('After ${tz.Location}');
  //   log('After ${tz.TimeZone}');
  //
  //   /// details of notification
  //   await FlutterLocalNotificationsPlugin().zonedSchedule(
  //     2,
  //     title,
  //     body,
  //     tz.TZDateTime(
  //       tz.local,
  //       2025,
  //       2,
  //       28,
  //       2,
  //       25,
  //     ),
  //     // tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     matchDateTimeComponents: DateTimeComponents.time, // لضمان تكرار الإشعار يوميًا
  //     uiLocalNotificationDateInterpretation:  UILocalNotificationDateInterpretation.absoluteTime,
  //     platformChannelSpecifics,
  //     payload: 'item x',
  //   );
  // }
  //
  // /// for make notification in specific time
  // tz.TZDateTime nextInstanceOfTime(int hour, int minute) {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate =
  //   tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  //
  //   // إذا كان الوقت قد فات اليوم، اضبطه ليوم الغد
  //   if (scheduledDate.isBefore(now)) {
  //     scheduledDate = scheduledDate.add(const Duration(days: 1));
  //   }
  //
  //   return scheduledDate;
  // }
  //

  void cancelNotification(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id);
  }

}


/// click on notification
void onTapNotification(NotificationResponse notificationResponse) {

}
