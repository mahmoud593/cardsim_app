import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light);

  void toggleTheme() {
    state == ThemeState.light
        ? emit(ThemeState.dark)
        : emit(ThemeState.light);
  }
}
