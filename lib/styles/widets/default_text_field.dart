import 'package:flutter/material.dart';
import 'package:games_app/styles/colors/color_manager.dart';


class DefaultTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  bool withSuffix;
  bool isPassword;
  bool viewPassword;
  bool? enable;
  IconData? suffixIcon;
  int? maxLines;
  Color? fillColor;

   DefaultTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.textInputAction,
    this.withSuffix = false,
    this.isPassword = false,
     this.viewPassword=true,
    this.suffixIcon,
    this.enable = true,
    this.maxLines = 1,
     required this.fillColor,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        textDirection: TextDirection.ltr,
        enabled: widget.enable,
        style: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height*0.02,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          filled:  true,
          fillColor: widget.fillColor,
          errorStyle: TextStyle(
            fontSize: MediaQuery.sizeOf(context).height*0.015,
            color: Colors.red,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: MediaQuery.sizeOf(context).height*0.02,
            color: ColorManager.lightGrey,
          ),
          suffixIcon: widget.withSuffix==true ?
          IconButton(
            onPressed: () {
              setState(() {
                widget.viewPassword = !widget.viewPassword;
              });
            },
            icon: widget.viewPassword == false
                ? const Icon(
                Icons.visibility_outlined,
            color: Colors.grey,
            )
                : const Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
            ),
          ) :null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).height*0.022,
            vertical: MediaQuery.sizeOf(context).height*0.01
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.gray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.gray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.gray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.01),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.01),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: ColorManager.gray,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.01),
          ),
        ),
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        maxLines: widget.maxLines,
        obscureText: widget.isPassword?widget.viewPassword:false,
      ),
    );
  }
}
