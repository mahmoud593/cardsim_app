import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light);

  void toggleTheme() {
    if(UserDataFromStorage.themeIsDarkMode == false){
      UserDataFromStorage.setThemeIsDarkMode(true);
      emit(ThemeState.dark);
    }
    else{
      UserDataFromStorage.setThemeIsDarkMode(false);
      emit(ThemeState.light);
    }
  }
}
