import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/presentation/view/widgets/home_screen_body.dart';

import '../../../../styles/text_styles/text_styles.dart';
import '../../../bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';
import '../controller/theme_cubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0.0,
        title: Text(
          'مساء الخير, Mazen Gamal !',
          style: TextStyles.textStyle18Bold.copyWith(),
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300), // Animation duration
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: child.key == const ValueKey('dark')
                          ? Tween<double>(begin: 1.0, end: 0.75).animate(animation)
                          : Tween<double>(begin: 0.75, end: 1.0).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: themeState == ThemeState.dark
                      ? const Icon(Icons.light_mode, key: ValueKey('dark'), size: 30)
                      : const Icon(Icons.dark_mode, key: ValueKey('light'), size: 30),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: HomeScreenBody(),
      ),
    );
  }
}
