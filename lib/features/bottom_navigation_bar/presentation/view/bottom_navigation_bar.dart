import 'dart:convert';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/bottom_nav_widget.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  String subtitle = '';
  String content = '';
  String data = '';

  @override
  void initState() {
    super.initState();

    // استقبال الإشعارات داخل التطبيق
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      setState(() {
        subtitle = event.notification.body!;
        content = event.notification.body!;
        data = event.notification.additionalData?['data'];
      });
    });

    // التعامل مع فتح الإشعار
    OneSignal.Notifications.addClickListener((event) {
      print('Notification Opened: ${event.notification.jsonRepresentation()}');
    });

    // جلب حالة الاشتراك وتحديث Firestore
    updateUserOSUserID();
    BottomNavCubit.get(context).getUserInfo(context: context);

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

  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: BottomNavCubit.get(context).scaffoldKey,
          body: WillPopScope(
            onWillPop: (){
              return Future.value(false);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: BottomNavCubit.get(context).bottomNavScreens[BottomNavCubit.get(context).currentIndex],
            ),
          ),

          /// bottom nav bar
          bottomNavigationBar: const BottomNavWidget(),

        );
      },
    );
  }
}

Future<void> sendNotification() async {
  const String oneSignalAppId = "dae07f47-e131-4130-a4fa-a7edb578c67b"; // ✅ استبدلها بـ App ID الخاص بك
  const String oneSignalApiKey = "os_v2_app_3lqh6r7bgfatbjh2u7w3k6ggpnniqrdexh6egmepomv27oroet4ujl3clsp7hp4uqdmqrrqw63p72s5goa6v3ycmy3xskm7ynzjvcuy"; // ✅ استبدلها بـ API Key الخاص بك

  var url = Uri.parse("https://onesignal.com/api/v1/notifications");

  var headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Basic $oneSignalApiKey", // ✅ المصادقة باستخدام REST API Key
  };

  var body = jsonEncode({
    "app_id": oneSignalAppId,
    "include_player_ids": ["eaf2dcd7-a1e2-4cb6-ae5c-c39a3bc3a752a"], // ✅ استبدلها بـ playerId للمستخدم
    "headings": {"en": "Flutter in Depth"},
    "contents": {"en": "New series lessons from Code With Ammar"},
    "data": {"custom_key": "this is our data"},
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print("✅ Notification sent successfully!");
  } else {
    print("❌ Failed to send notification: ${response.body}");
  }
}