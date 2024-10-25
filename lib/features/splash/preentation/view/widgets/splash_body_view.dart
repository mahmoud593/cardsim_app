import 'package:flutter/material.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'package:games_app/features/splash/preentation/view/widgets/logo_image.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class SplashBodyView extends StatefulWidget {
  const SplashBodyView({super.key});

  @override
  State<SplashBodyView> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashBodyView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    UserDataFromStorage.getData();
    timeDelay(context: context);
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: const Offset(0, 0))
            .animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackground : ColorManager.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: slideAnimation,
            builder: (context, _) {
              return SlideTransition(
                  position: slideAnimation, child: const LogoImage());
            },
          ),
        ],
      ),
    );
  }
}

void timeDelay({required BuildContext context}) {
  Future.delayed(const Duration(seconds: 2), () async {
     UserDataFromStorage.userTokenFromStorage != "" ?
    customPushAndRemoveUntil(context, const LoginScreen()):
    customPushAndRemoveUntil(context, const LoginScreen());
  });
}
