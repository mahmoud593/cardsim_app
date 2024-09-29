import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BottomNavCubit.get(context)
                .bottomNavScreens[BottomNavCubit.get(context).currentIndex],
          ),

          /// bottom nav bar
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: BottomNavCubit.get(context).currentIndex,
            onTap: (value) {
              if(value == 0){
                _scaffoldKey.currentState?.openDrawer();
              }else{
                BottomNavCubit.get(context).changeBottomNav(value);
              }
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
            ),
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.lightGrey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_outlined),
                label: 'القائمة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'الطلبات',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.transparent,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'الرصيد',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'الإعدادات',
              ),
            ],
          ),


          drawer: const Drawer(
            child: DrawerWidget(),
          ),

          /// floating action button
          floatingActionButton: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorManager.primaryLight2,
                width: 3,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () {
                BottomNavCubit.get(context).changeBottomNav(2);
              },
              shape: const CircleBorder(),
              backgroundColor: ColorManager.primary,
              child: const Icon(Icons.home_filled, color: ColorManager.white),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
