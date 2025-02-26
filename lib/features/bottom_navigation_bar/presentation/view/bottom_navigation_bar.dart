import 'dart:convert';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/services/local_notification_services.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/bottom_nav_widget.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../core/services/on_signal_notification.dart';

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


    OnSignalNotificationServices.init();
    handleNotificationWhenAppOpened();

    updateUserOSUserID();
    BottomNavCubit.get(context).getUserInfo(context: context);
    AuthCubit.get(context).getUserInfo(context: context);
    onClickNotificationSetup();
  }

  void onClickNotificationSetup() async {

    bool _notificationHandled = false;

    OneSignal.Notifications.addClickListener((event) {
      print('Notification Opened: ${event.notification.jsonRepresentation()}');

        if(!_notificationHandled){
          _notificationHandled = true;
          showDialog(context: context, builder: (context){
            return AlertDialog(
              backgroundColor: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackground : ColorManager.gray,
              title: Text('${event.notification.title}'),
              content:Text('${event.notification.body}'),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: DefaultButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      text: 'مقروءة'
                  ),
                ),
              ],
            );
          });
        }
    });
  }

  void handleNotificationWhenAppOpened() async {

    String? lastNotificationId;
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {

      final String currentMessageId = event.notification.jsonRepresentation();

      if (lastNotificationId == currentMessageId) {
        return;
      }
      lastNotificationId = currentMessageId;

      print("Received notification in foreground: ${event.notification.jsonRepresentation()}");

      LocalNotificationServices.showBasicNotification(
        title:  event.notification.title!,
        body:  event.notification.body!,
      );

      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackground : ColorManager.gray,
          title: Text('${event.notification.title}'),
          content:  Text('${event.notification.body}'),
          actions: [
            Align(
              alignment: Alignment.center,
              child: DefaultButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  text: 'مقروءة'
              ),
            ),
          ],
        );
      });

      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        setState(() {
          subtitle = event.notification.body!;
          content = event.notification.body!;
          data = event.notification.additionalData?['data'];
        });
      });

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

  
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        print('current index is ${BottomNavCubit.get(context).currentIndex}');
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

  const String oneSignalAppId = "bc085bc7-0536-4bdb-8609-1c634b43eb31"; // ✅ استبدلها بـ App ID الخاص بك
  const String oneSignalApiKey = "os_v2_app_3lqh6r7bgfatbjh2u7w3k6ggppvs4bru4hhuv3fmzkudrzadfsuemctbutpmm66tcocidxl5xkfzf564uyctzqlicdba7mrk7be3m6i"; // ✅ استبدلها بـ API Key الخاص بك

  var url = Uri.parse("https://onesignal.com/api/v1/notifications");

  var headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Basic $oneSignalApiKey", // ✅ المصادقة باستخدام REST API Key
  };

  var body = jsonEncode({
    "app_id": oneSignalAppId,
    "include_player_ids": ["f32164e3-01cc-405c-bcd4-1e5d354d872a"], // ✅ استبدلها بـ playerId للمستخدم
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