import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.controller,
    this.textInputType,
    this.maxLines = 1,
    this.initialValue,
    this.suffixIcon,
    this.onSubmitted,
    this.onClear,
  });

  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onClear;
  final String? hintText;
  final String? initialValue;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final int? maxLines;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: textInputType,
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: obscureText!,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style:  TextStyle(color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black),
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                controller?.clear();
                onClear!();
              },
              icon: const Icon(Icons.close, color: Color(0xffC9CECF)),
            ),
            IconButton(
              onPressed: () {
                onSubmitted!(controller!.text);
              },
              icon: Icon(suffixIcon, color: const Color(0xffC9CECF)),
            ),
          ],
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFF949D9E),
            height: 1
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color(0xFFE6E9E9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Color(0xFFE6E9E9))),
        filled: true,
        fillColor:isLight? ColorManager.darkWhite :ColorManager.darkThemeBackgroundLight,
      ),
    );
  }
}
