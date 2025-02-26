
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnSignalNotificationServices{

  static Future init() async {

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    // App ID
    OneSignal.initialize("bc085bc7-0536-4bdb-8609-1c634b43eb31");

    OneSignal.Notifications.requestPermission(true);

  }

  static Future handleNotificationAppOpen() async {

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {

      // use for tracking only one notification
      final String currentMessageId = event.notification.jsonRepresentation();

      print("Received notification in foreground: ${event.notification.jsonRepresentation()}");

    });

  }

  static Future openNotification() async {

    OneSignal.Notifications.addClickListener((event) {
      print('Notification Opened: ${event.notification.jsonRepresentation()}');
    });

  }

  Future<void> updateUserOSUserID() async {
    final userId = OneSignal.User.pushSubscription.id;

    if (userId != null) {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid);
      print('User ID: ${FirebaseAuth.instance.currentUser?.uid}');

      await ref.update({'osUserID': userId});
    }
  }



}